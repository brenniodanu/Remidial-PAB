import 'package:flutter/material.dart';
import 'auth_service.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});
  final _emailController = TextEditingController();
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _authService.resetPassword(_emailController.text);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link reset terkirim ke email')));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: const Text('Send to email'),
            )
          ],
        ),
      ),
    );
  }
}