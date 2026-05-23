import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:odontologia_app/features/auth/services/user_validation_service.dart';
import 'package:odontologia_app/shared/widgets/main_navigation.dart';
import 'otp_screen.dart';
import '../../services/auth_service.dart';
import '../../services/user_validation_service.dart';
import '../../../../shared/widgets/main_navigation.dart';

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

    AuthService.sendOtp(
      phone: '+51${phoneController.text.trim()}',

      codeSent: (verificationId) {
        setState(() {
          this.verificationId = verificationId;
          codeSent = true;
          loading = false;
        });
      },
      onError: (error) {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
      },
    );
  }

  Future<void> verifyCode() async {
    setState(() {
      loading = true;
    });

    try {
      await AuthService.verifyOtp(
        verificationId: verificationId,
        otp: codeController.text.trim(),
      );

      final isAuthorized = await UserValidationService.isAuthorizedUser(
        phoneController.text.trim(),
      );

      if (!isAuthorized) {
        await AuthService.logout();

        if (!mounted) return;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('No estás autorizado')));

        setState(() {
          loading = false;
        });

        return;
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigation()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Código inválido')));
    }

    setState(() {
      loading = false;
    });
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
