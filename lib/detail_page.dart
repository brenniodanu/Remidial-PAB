import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DetailPage extends StatefulWidget {
  final Map article;
  const DetailPage({super.key, required this.article});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkIfFavorite();
  }

  checkIfFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('fav_list') ?? [];
    setState(() {
      isFavorite = favorites.any((item) => json.decode(item)['id'] == widget.article['id']);
    });
  }

  toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('fav_list') ?? [];
    
    if (isFavorite) {
      favorites.removeWhere((item) => json.decode(item)['id'] == widget.article['id']);
      setState(() => isFavorite = false);
    } else {
      favorites.add(json.encode({
        'id': widget.article['id'],
        'title': widget.article['title'],
        'image_url': widget.article['image_url'],
        'news_site': widget.article['news_site'],
        'summary': widget.article['summary']
      }));
      setState(() => isFavorite = true);
    }
    await prefs.setStringList('fav_list', favorites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Artikel'),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : Colors.grey),
            onPressed: toggleFavorite,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.article['image_url'] ?? '', fit: BoxFit.cover, width: double.infinity, height: 250, errorBuilder: (c, e, s) => const Icon(Icons.broken_image, size: 250)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.article['title'] ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Publisher: ${widget.article['news_site'] ?? ''}', style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  Text(widget.article['summary'] ?? '', style: const TextStyle(fontSize: 16, height: 1.5)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}