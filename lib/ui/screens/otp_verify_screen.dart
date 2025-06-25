import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'head_form_screen.dart';

class OTPVerifyScreen extends StatefulWidget {
  final String verificationId;
  final String phone;
  const OTPVerifyScreen({super.key, required this.verificationId, required this.phone});

  @override
  State<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  final otpController = TextEditingController();

  void verifyOTP() async {
    try {
      await AuthService().verifyOTP(widget.verificationId, otpController.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HeadFormScreen(phone: widget.phone)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Verification Failed: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          const Text("Enter the OTP sent to your number"),
          TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "OTP"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: verifyOTP, child: const Text("Verify"))
        ]),
      ),
    );
  }
}