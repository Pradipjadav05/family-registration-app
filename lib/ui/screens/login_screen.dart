import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'otp_verify_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void sendOTP() async {
    if (_formKey.currentState!.validate()) {
      await AuthService().sendOTP(phoneController.text, (verificationId) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OTPVerifyScreen(
              verificationId: verificationId,
              phone: phoneController.text,
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            const Text("Enter your phone number"),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Phone Number"),
              validator: (v) => v!.length == 10 ? null : "Enter valid 10-digit number",
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: sendOTP, child: const Text("Send OTP"))
          ]),
        ),
      ),
    );
  }
}