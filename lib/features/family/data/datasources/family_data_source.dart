import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/enums/family_member_role.dart';
import '../../domain/entities/add_member_result.dart';
import '../models/family_member_model.dart';
import '../models/family_model.dart';

class FamilyDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FamilyDataSource(this._firestore, this._auth);

  static const _defaultCategories = [
    'طعام',
    'مواصلات',
    'تعليم',
    'ترفيه',
    'ملابس',
    'صحة',
    'ادخار',
    'أخرى',
  ];

  Future<FamilyModel> createFamily(String name) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final userDoc = await _firestore
        .collection(FirestoreCollections.users)
        .doc(user.uid)
        .get();
    final userData = userDoc.data() ?? {};
    final firstName = userData['firstName'] as String? ?? '';
    final lastName = userData['lastName'] as String? ?? '';
    final displayName = '$firstName $lastName'.trim();

    final familyRef =
        _firestore.collection(FirestoreCollections.families).doc();
    final memberRef = _firestore
        .collection(FirestoreCollections.familyMembers)
        .doc(user.uid);

    await familyRef.set({
      'id': familyRef.id,
      'name': name.trim(),
      'managerId': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await memberRef.set({
      'familyId': familyRef.id,
      'userId': user.uid,
      'displayName': displayName.isEmpty ? user.email ?? '' : displayName,
      'email': user.email ?? '',
      'role': 'manager',
      'status': 'active',
      'monthlyBudget': null,
      'joinedAt': FieldValue.serverTimestamp(),
    });

    final categoryBatch = _firestore.batch();
    for (final categoryName in _defaultCategories) {
      final categoryRef =
          _firestore.collection(FirestoreCollections.categories).doc();
      categoryBatch.set(categoryRef, {
        'id': categoryRef.id,
        'familyId': familyRef.id,
        'name': categoryName,
        'isDefault': true,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    await categoryBatch.commit();

    return FamilyModel(
      id: familyRef.id,
      name: name.trim(),
      managerId: user.uid,
      createdAt: DateTime.now(),
    );
  }

  Future<FamilyModel?> getUserFamily() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final memberDoc = await _firestore
        .collection(FirestoreCollections.familyMembers)
        .doc(user.uid)
        .get();

    if (!memberDoc.exists) return null;

    final memberData = memberDoc.data()!;
    if (memberData['status'] != 'active') return null;

    final familyId = memberData['familyId'] as String?;
    if (familyId == null) return null;

    final familyDoc = await _firestore
        .collection(FirestoreCollections.families)
        .doc(familyId)
        .get();

    if (!familyDoc.exists) return null;

    return FamilyModel.fromFirestore(familyDoc.data()!);
  }

  Future<AddMemberResult> addMember({
    required String familyId,
    required String displayName,
    required String email,
    required FamilyMemberRole role,
    double? monthlyBudget,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final normalizedEmail = email.trim().toLowerCase();

    final userQuery = await _firestore
        .collection(FirestoreCollections.users)
        .where('email', isEqualTo: normalizedEmail)
        .limit(1)
        .get();

    final userExists = userQuery.docs.isNotEmpty;
    String? recipientUserId;

    if (userExists) {
      recipientUserId = userQuery.docs.first.id;

      final existingMember = await _firestore
          .collection(FirestoreCollections.familyMembers)
          .doc(recipientUserId)
          .get();

      if (existingMember.exists &&
          existingMember.data()?['status'] == 'active') {
        throw AlreadyInFamilyException();
      }

      final existingInvite = await _firestore
          .collection(FirestoreCollections.invitations)
          .where('senderId', isEqualTo: user.uid)
          .where('recipientId', isEqualTo: recipientUserId)
          .where('familyId', isEqualTo: familyId)
          .where('status', isEqualTo: 'pending')
          .limit(1)
          .get();

      if (existingInvite.docs.isNotEmpty) {
        throw AlreadyInvitedException();
      }
    } else {
      final existingEmailInvite = await _firestore
          .collection(FirestoreCollections.invitations)
          .where('senderId', isEqualTo: user.uid)
          .where('recipientEmail', isEqualTo: normalizedEmail)
          .where('familyId', isEqualTo: familyId)
          .where('status', isEqualTo: 'pending')
          .limit(1)
          .get();

      if (existingEmailInvite.docs.isNotEmpty) {
        throw AlreadyInvitedException();
      }
    }

    final familyDoc = await _firestore
        .collection(FirestoreCollections.families)
        .doc(familyId)
        .get();
    final familyName = familyDoc.data()?['name'] as String? ?? '';

    final senderDoc = await _firestore
        .collection(FirestoreCollections.users)
        .doc(user.uid)
        .get();
    final senderData = senderDoc.data() ?? {};
    final senderName =
        '${senderData['firstName'] ?? ''} ${senderData['lastName'] ?? ''}'
            .trim();

    final batch = _firestore.batch();

    final memberRef =
        _firestore.collection(FirestoreCollections.familyMembers).doc();

    batch.set(memberRef, {
      'id': memberRef.id,
      'familyId': familyId,
      'userId': null,
      'displayName': displayName.trim(),
      'email': normalizedEmail,
      'role': role.toJson(),
      'status': 'pending',
      'monthlyBudget': monthlyBudget,
      'invitedAt': FieldValue.serverTimestamp(),
      'joinedAt': null,
    });

    final inviteRef =
        _firestore.collection(FirestoreCollections.invitations).doc();

    batch.set(inviteRef, {
      'familyId': familyId,
      'familyName': familyName,
      'senderId': user.uid,
      'senderName': senderName.isEmpty ? user.email : senderName,
      'recipientId': recipientUserId,
      'recipientEmail': normalizedEmail,
      'pendingMemberId': memberRef.id,
      'displayName': displayName.trim(),
      'role': role.toJson(),
      'monthlyBudget': monthlyBudget,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    await batch.commit();

    final member = FamilyMemberModel(
      id: memberRef.id,
      familyId: familyId,
      displayName: displayName.trim(),
      email: normalizedEmail,
      role: role,
      status: 'pending',
      monthlyBudget: monthlyBudget,
    );

    return AddMemberResult(
      member: member,
      inviteStatus:
          userExists ? InviteStatus.sent : InviteStatus.userNotFound,
    );
  }
}

class AlreadyInFamilyException implements Exception {}

class AlreadyInvitedException implements Exception {}
