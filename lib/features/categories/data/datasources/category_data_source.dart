import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants/firestore_collections.dart';
import '../models/category_model.dart';

class CategoryDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CategoryDataSource(this._firestore, this._auth);

  Future<List<CategoryModel>> getCategories(String familyId) async {
    final snapshot = await _firestore
        .collection(FirestoreCollections.categories)
        .where('familyId', isEqualTo: familyId)
        .where('isDeleted', isEqualTo: false)
        .orderBy('createdAt')
        .get();

    return snapshot.docs
        .map((doc) => CategoryModel.fromFirestore(doc.id, doc.data()))
        .toList();
  }

  Future<CategoryModel> createCategory({
    required String familyId,
    required String name,
    required String icon,
    required int colorValue,
  }) async {
    if (_auth.currentUser == null) throw Exception('User not authenticated');

    final ref = _firestore.collection(FirestoreCollections.categories).doc();
    final model = CategoryModel(
      id: ref.id,
      familyId: familyId,
      name: name,
      icon: icon,
      colorValue: colorValue,
      isDefault: false,
      isDeleted: false,
      createdAt: DateTime.now(),
    );

    await ref.set({
      'id': ref.id,
      ...model.toFirestore(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    return model;
  }

  Future<CategoryModel> updateCategory({
    required String id,
    required String name,
    required String icon,
    required int colorValue,
  }) async {
    if (_auth.currentUser == null) throw Exception('User not authenticated');

    await _firestore
        .collection(FirestoreCollections.categories)
        .doc(id)
        .update({
      'name': name,
      'icon': icon,
      'colorValue': colorValue,
    });

    final doc = await _firestore
        .collection(FirestoreCollections.categories)
        .doc(id)
        .get();

    return CategoryModel.fromFirestore(doc.id, doc.data()!);
  }

  Future<void> deleteCategory(String id) async {
    if (_auth.currentUser == null) throw Exception('User not authenticated');

    await _firestore
        .collection(FirestoreCollections.categories)
        .doc(id)
        .update({'isDeleted': true});
  }
}
