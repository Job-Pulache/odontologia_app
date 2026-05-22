import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final codeController = TextEditingController();

  String verificationId = '';

  bool codeSent = false;
  bool loading = false;

  Future<void> sendCode() async {
    setState(() {
      loading = true;
    });

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneController.text,

      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },

      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? 'Error')));
      },

      codeSent: (String verId, int? resendToken) {
        verificationId = verId;

        setState(() {
          codeSent = true;
        });
      },

      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );

    setState(() {
      loading = false;
    });
  }

  Future<void> verifyCode() async {
    setState(() {
      loading = true;
    });

    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: codeController.text,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    setState(() {
      loading = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Login exitoso')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login OTP')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: '+51 999999999'),
            ),

            const SizedBox(height: 20),

            if (codeSent)
              TextField(
                controller: codeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Código OTP'),
              ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: loading
                  ? null
                  : codeSent
                  ? verifyCode
                  : sendCode,

              child: loading
                  ? const CircularProgressIndicator()
                  : Text(codeSent ? 'Verificar Código' : 'Enviar Código'),
            ),
          ],
        ),
      ),
    );
  }
}
