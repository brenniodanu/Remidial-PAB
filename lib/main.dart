import 'package:flutter/material.dart';
import 'splash_screen.dart'; // <--- Pastikan file splash screen di-import

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SpaceNewsApp());
}

class SpaceNewsApp extends StatelessWidget {
  const SpaceNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceNews Core',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(), // <--- WAJIB DI SINI agar pertama kali muncul
      debugShowCheckedModeBanner: false,
    );
  }
}