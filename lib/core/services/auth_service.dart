import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String verificationId = '';

  // =========================================
  // ENVIAR OTP
  // =========================================

  static Future<void> sendOtp({
    required String phone,
    required Function(String) onCodeSent,
    required Function(String) onError,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,

      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },

      verificationFailed: (FirebaseAuthException e) {
        onError(e.message ?? 'Error');
      },

      codeSent: (String verification, int? resendToken) {
        verificationId = verification;
        onCodeSent(verification);
      },

      codeAutoRetrievalTimeout: (String verification) {
        verificationId = verification;
      },
    );
  }

  // =========================================
  // VERIFICAR OTP
  // =========================================

  static Future<bool> verifyOtp(String code) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );

      await _auth.signInWithCredential(credential);

      return true;
    } catch (e) {
      return false;
    }
  }
}
