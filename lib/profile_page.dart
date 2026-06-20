import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<Map<String, String>> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'username': prefs.getString('username') ?? 'danu',
      'name': prefs.getString('name') ?? 'Jelsica',
      'email': prefs.getString('email') ?? 's@gmail.com',
      'instagram': prefs.getString('instagram') ?? 'anjay',
    };
  }

  // Komponen Helper dipindahkan ke dalam struktur kelas yang benar
  Widget _buildProfileItem(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xfff1f3f4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xff1a73e8)),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: FutureBuilder<Map<String, String>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          var userData = snapshot.data ?? {
            'username': 'danu',
            'name': 'Jelsica',
            'email': 's@gmail.com',
            'instagram': 'anjay'
          };

          return SingleChildScrollView(
            child: Column(
              children: [
                // Bagian Atas: Background Biru Melengkung Oval Basal
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: const BoxDecoration(
                    color: Color(0xffbce3ff),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(160),
                      bottomRight: Radius.circular(160),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Profile',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 16),
                      // Foto Profil Berlingkar Ungu Muda
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: Color(0xffe1d5ff), shape: BoxShape.circle),
                        child: const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.person, size: 45, color: Color(0xff4a3780)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Bagian Bawah: List Menu Kotak Putih
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      _buildProfileItem(Icons.person, userData['username']!),
                      _buildProfileItem(Icons.badge, userData['name']!),
                      _buildProfileItem(Icons.email, userData['email']!),
                      _buildProfileItem(Icons.location_on, userData['instagram']!),
                      const SizedBox(height: 32),
                      
                      // Tombol Log Out
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent, 
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                          ),
                          onPressed: () async {
                            await authService.signOut();
                            if (context.mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                                (route) => false,
                              );
                            }
                          },
                          child: const Text(
                            'Log Out', 
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}