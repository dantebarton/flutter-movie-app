import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ghibli_info_app/album.dart';
import 'package:ghibli_info_app/pages/detail_page.dart';
import 'photo_item.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

final List<Album> _items = [
  
];

class _MyHomePageState extends State<MyHomePage> {
  List <dynamic> films = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GridViewExample"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchFilms,)
      // body: Padding(
      //   padding: const EdgeInsets.all(3.0),
      //   child: GridView.builder(
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 0),
      //     itemCount: _items.length,
      //     itemBuilder: (context, index) {
      //       return GestureDetector(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => DetailPage(
      //                   image: _items[index].image, title: _items[index].title),
      //             ),
      //           );
      //         },
      //         child: Container(
      //           decoration: BoxDecoration(
      //             image: DecorationImage(
      //               fit: BoxFit.cover,
      //               image: NetworkImage(_items[index].image),
      //             ),
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
     
    );
  }

 void fetchFilms() async {
  print("Fetching films...");
  const url = 'https://ghibliapi.vercel.app/films/';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  
  if (response.statusCode == 200) {
    final body = response.body;
    final List<dynamic> json = jsonDecode(body); // Decode as List
    
    // Map each film object to an Album object
    final List<Album> films = json.map((e) => Album.fromMap(e)).toList();
    
    // Print descriptions of all films fetched
    for (var film in films) {
      print(film.title); // Assuming description is a field in Album
    }
    
    print("Fetching films completed");
  } else {
    print("Failed to fetch films. Status code: ${response.statusCode}");
  }
}



}
