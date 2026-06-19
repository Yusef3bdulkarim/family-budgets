import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants/firestore_collections.dart';
import '../../domain/entities/invitation_entity.dart';
import '../models/invitation_model.dart';

class InvitationDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  InvitationDataSource(this._firestore, this._auth);

  Future<List<InvitationModel>> getPendingInvitations() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final query = await _firestore
        .collection(FirestoreCollections.invitations)
        .where('recipientId', isEqualTo: user.uid)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .get();

    return query.docs
        .map((doc) => InvitationModel.fromFirestore(doc.id, doc.data()))
        .toList();
  }

  Future<void> acceptInvitation(InvitationEntity invitation) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final batch = _firestore.batch();

    final pendingRef = _firestore
        .collection(FirestoreCollections.familyMembers)
        .doc(invitation.pendingMemberId);
    batch.delete(pendingRef);

    final memberRef = _firestore
        .collection(FirestoreCollections.familyMembers)
        .doc(user.uid);
    batch.set(memberRef, {
      'familyId': invitation.familyId,
      'userId': user.uid,
      'displayName': invitation.displayName,
      'email': invitation.recipientEmail,
      'role': invitation.role.toJson(),
      'status': 'active',
      'monthlyBudget': invitation.monthlyBudget,
      'joinedAt': FieldValue.serverTimestamp(),
    });

    final inviteRef = _firestore
        .collection(FirestoreCollections.invitations)
        .doc(invitation.id);
    batch.update(inviteRef, {'status': 'accepted'});

    await batch.commit();

    // Auto-reject other pending invitations for this user.
    final otherInvites = await _firestore
        .collection(FirestoreCollections.invitations)
        .where('recipientId', isEqualTo: user.uid)
        .where('status', isEqualTo: 'pending')
        .get();

    if (otherInvites.docs.isNotEmpty) {
      final cleanupBatch = _firestore.batch();
      for (final doc in otherInvites.docs) {
        cleanupBatch.update(doc.reference, {'status': 'auto_rejected'});
      }
      await cleanupBatch.commit();
    }
  }

  Future<void> rejectInvitation(InvitationEntity invitation) async {
    final batch = _firestore.batch();

    final inviteRef = _firestore
        .collection(FirestoreCollections.invitations)
        .doc(invitation.id);
    batch.update(inviteRef, {'status': 'rejected'});

    final pendingRef = _firestore
        .collection(FirestoreCollections.familyMembers)
        .doc(invitation.pendingMemberId);
    batch.delete(pendingRef);

    await batch.commit();
  }

  /// Returns true if a pending email invitation was found and auto-claimed.
  Future<bool> claimPendingMembershipByEmail() async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) return false;

    final normalizedEmail = user.email!.toLowerCase();

    final query = await _firestore
        .collection(FirestoreCollections.invitations)
        .where('recipientEmail', isEqualTo: normalizedEmail)
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: false)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return false;

    final inviteDoc = query.docs.first;
    final data = inviteDoc.data();
    final pendingMemberId = data['pendingMemberId'] as String? ?? '';

    final batch = _firestore.batch();

    if (pendingMemberId.isNotEmpty) {
      final pendingRef = _firestore
          .collection(FirestoreCollections.familyMembers)
          .doc(pendingMemberId);
      batch.delete(pendingRef);
    }

    final memberRef = _firestore
        .collection(FirestoreCollections.familyMembers)
        .doc(user.uid);
    batch.set(memberRef, {
      'familyId': data['familyId'],
      'userId': user.uid,
      'displayName': data['displayName'],
      'email': normalizedEmail,
      'role': data['role'],
      'status': 'active',
      'monthlyBudget': data['monthlyBudget'],
      'joinedAt': FieldValue.serverTimestamp(),
    });

    batch.update(inviteDoc.reference, {
      'status': 'accepted',
      'recipientId': user.uid,
    });

    await batch.commit();

    final others = await _firestore
        .collection(FirestoreCollections.invitations)
        .where('recipientEmail', isEqualTo: normalizedEmail)
        .where('status', isEqualTo: 'pending')
        .get();

    if (others.docs.isNotEmpty) {
      final cleanupBatch = _firestore.batch();
      for (final doc in others.docs) {
        // recipientId must be set so the Firestore update rule (email-match branch)
        // sees affectedKeys = ['status', 'recipientId'] and recipientId == user.uid.
        cleanupBatch.update(doc.reference, {
          'status': 'auto_rejected',
          'recipientId': user.uid,
        });
      }
      await cleanupBatch.commit();
    }

    return true;
  }
}
