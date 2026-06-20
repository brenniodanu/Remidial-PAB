import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'welcome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleSession();
  }

  // Fungsi untuk mengatur delay 3 detik dan handling session storage
  Future<void> _handleSession() async {
    // 1. Wajib berjalan dengan delay tepat 3 detik
    await Future.delayed(const Duration(seconds: 3));
    
    // 2. Session Handling menggunakan SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (mounted) {
      // Mengarahkan halaman berdasarkan status session login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isLoggedIn ? const WelcomePage() : const LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // GANTI DI SINI: Menggunakan gambar aset dari Freepik
            Image.asset(
              'assets/logo.png',
              width: 150, // Sesuaikan ukuran lebar logo
              height: 150, // Sesuaikan ukuran tinggi logo
            ),
            const SizedBox(height: 32),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
            ),
          ],
        ),
      ),
    );
  }
}