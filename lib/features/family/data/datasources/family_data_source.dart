import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants/firestore_collections.dart';
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
}
