import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ghibli_info_app/album.dart';
import 'package:ghibli_info_app/pages/detail_page.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Album>> _filmsFuture;

  @override
  void initState() {
    super.initState();
    _filmsFuture = fetchFilms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ghibli Films Grid"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: FutureBuilder<List<Album>>(
          future: _filmsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final films = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: films.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            image: films[index].image,
                            title: films[index].originalTitle,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(films[index].image),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No films available.'));
            }
          },
        ),
      ),
    );
  }

  Future<List<Album>> fetchFilms() async {
    print("Fetching films...");
    const url = 'https://ghibliapi.vercel.app/films/';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final List<dynamic> json = jsonDecode(body);
      final List<Album> films = json.map((e) => Album.fromMap(e)).toList();
      return films;
    } else {
      throw Exception("Failed to fetch films. Status code: ${response.statusCode}");
    }
  }
}
