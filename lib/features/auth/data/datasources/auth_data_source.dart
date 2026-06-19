import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../core/constants/firestore_collections.dart';
import '../models/user_model.dart';

class AuthDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;

  AuthDataSource(this._auth, this._firestore, this._googleSignIn);

  Future<UserModel> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user!;

    final model = UserModel(
      uid: user.uid,
      email: email,
      firstName: firstName,
      lastName: lastName,
      emailVerified: user.emailVerified,
    );

    await _firestore.collection(FirestoreCollections.users).doc(user.uid).set(model.toFirestore());
    await user.sendEmailVerification();

    return model;
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirestore(credential.user!);
  }

  Future<UserModel> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google sign-in was cancelled');
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    final user = userCredential.user!;

    final doc = await _firestore.collection(FirestoreCollections.users).doc(user.uid).get();
    if (!doc.exists) {
      final names = user.displayName?.split(' ') ?? [''];
      final model = UserModel(
        uid: user.uid,
        email: user.email ?? '',
        firstName: names.first,
        lastName: names.length > 1 ? names.sublist(1).join(' ') : '',
        emailVerified: user.emailVerified,
      );
      await _firestore.collection(FirestoreCollections.users).doc(user.uid).set(model.toFirestore());
      return model;
    }

    return _userFromFirestore(user);
  }

  Future<UserModel> signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    final userCredential = await _auth.signInWithCredential(oauthCredential);
    final user = userCredential.user!;

    final doc = await _firestore.collection(FirestoreCollections.users).doc(user.uid).get();
    if (!doc.exists) {
      final model = UserModel(
        uid: user.uid,
        email: user.email ?? appleCredential.email ?? '',
        firstName: appleCredential.givenName ?? '',
        lastName: appleCredential.familyName ?? '',
        emailVerified: user.emailVerified,
      );
      await _firestore.collection(FirestoreCollections.users).doc(user.uid).set(model.toFirestore());
      return model;
    }

    return _userFromFirestore(user);
  }

  Future<void> forgotPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  Future<bool> checkEmailVerification() async {
    final user = _auth.currentUser;
    if (user == null) return false;
    await user.reload();
    return _auth.currentUser!.emailVerified;
  }

  Future<void> logout() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return _userFromFirestore(user);
  }

  Future<UserModel> _userFromFirestore(User user) async {
    final doc = await _firestore.collection(FirestoreCollections.users).doc(user.uid).get();
    if (!doc.exists) {
      return UserModel(
        uid: user.uid,
        email: user.email ?? '',
        firstName: '',
        lastName: '',
        emailVerified: user.emailVerified,
      );
    }
    return UserModel.fromFirestore(
      doc.data()!,
      uid: user.uid,
      emailVerified: user.emailVerified,
    );
  }
}
