import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'detail_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // Mengambil data favorit langsung dari SharedPreferences lokal (Bukan Firebase)
  Future<List<Map<String, dynamic>>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favList = prefs.getStringList('fav_list') ?? [];
    return favList.map((item) => json.decode(item) as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Tidak ada artikel favorit',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final docs = snapshot.data!;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index];
              return ListTile(
                leading: data['image_url'] != null && data['image_url'].toString().isNotEmpty
                    ? Image.network(
                        data['image_url'], 
                        width: 80, 
                        height: 60,
                        fit: BoxFit.cover, 
                        errorBuilder: (c, e, s) => const Icon(Icons.broken_image, size: 50),
                      )
                    : const Icon(Icons.image, size: 50),
                title: Text(
                  data['title'] ?? 'No Title', 
                  maxLines: 2, 
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(data['news_site'] ?? ''),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => DetailPage(article: data))
                  ).then((_) {
                    // Memicu refresh halaman saat kembali dari Detail Page jika status favorit berubah
                    setState(() {});
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}