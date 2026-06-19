import 'package:firebase_auth/firebase_auth.dart';

import 'failure.dart';

class FirebaseErrorHandler {
  static Failure handle(dynamic error) {
    if (error is FirebaseAuthException) {
      return AuthFailure(
        message: _mapAuthCode(error.code),
        code: _numericCode(error.code),
      );
    }
    if (error is FirebaseException) {
      return ServerFailure(message: error.message ?? 'Firebase error');
    }
    return const ServerFailure(message: 'Something went wrong. Please try again.');
  }

  static String _mapAuthCode(String code) {
    return switch (code) {
      'email-already-in-use' => 'This email is already registered',
      'invalid-email' => 'Invalid email address',
      'user-disabled' => 'This account has been disabled',
      'user-not-found' => 'No account found with this email',
      'wrong-password' => 'Incorrect password',
      'weak-password' => 'Password is too weak',
      'operation-not-allowed' => 'This sign-in method is not enabled',
      'too-many-requests' => 'Too many attempts. Please try again later',
      'invalid-credential' => 'Invalid credentials',
      'account-exists-with-different-credential' =>
        'An account already exists with a different sign-in method',
      _ => 'Authentication failed',
    };
  }

  static int _numericCode(String code) {
    return switch (code) {
      'email-already-in-use' => 409,
      'user-not-found' || 'wrong-password' || 'invalid-credential' => 401,
      'user-disabled' => 403,
      'too-many-requests' => 429,
      _ => 500,
    };
  }
}
