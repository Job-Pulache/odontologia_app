import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../../../shared/widgets/main_navigation.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phone;

  const OtpScreen({
    super.key,
    required this.verificationId,
    required this.phone,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();

  bool isLoading = false;

  Future<void> verifyOtp() async {
    if (otpController.text.length < 6) return;

    setState(() {
      isLoading = true;
    });

    try {
      await AuthService.verifyOtp(
        verificationId: widget.verificationId,
        otp: otpController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainNavigation()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Código inválido')));
    }

    setState(() {
      isLoading = false;
    });
  }

  Widget otpBox(int index) {
    return SizedBox(
      width: 48,
      child: TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,

        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xFFF5F7FA),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),

        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios),
              ),

              const SizedBox(height: 30),

              const Text(
                'Verificar Código',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Text(
                'Ingresamos un código a ${widget.phone}',
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: List.generate(6, (index) => otpBox(index)),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton(
                  onPressed: isLoading ? null : verifyOtp,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Verificar e Ingresar',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
