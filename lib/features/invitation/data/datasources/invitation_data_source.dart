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
}
