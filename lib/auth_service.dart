import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> signUp(String name, String email, String password, String instagram) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('instagram', instagram);
    await prefs.setBool('isLoggedIn', true);
    return true;
  }

  Future<bool> signIn(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    return true;
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> resetPassword(String email) async {
    // Simulasi reset password
    await Future.delayed(const Duration(milliseconds: 500));
  }
}