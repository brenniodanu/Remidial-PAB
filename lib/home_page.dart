import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  fetchArticles() async {
    final response = await http.get(Uri.parse('https://api.spaceflightnewsapi.net/v4/articles/?limit=20'));
    if (response.statusCode == 200) {
      setState(() {
        articles = json.decode(response.body)['results'];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SpaceNews Core')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (articles.isNotEmpty) ...[
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(article: articles[0]))),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(articles[0]['image_url']), fit: BoxFit.cover),
                        ),
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          color: Colors.black54,
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            articles[0]['title'],
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: articles.length - 1,
                    itemBuilder: (context, index) {
                      final item = articles[index + 1];
                      return ListTile(
                        leading: Image.network(item['image_url'], width: 100, fit: BoxFit.cover),
                        title: Text(item['title'], maxLines: 2),
                        subtitle: Text(item['news_site']),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(article: item))),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}