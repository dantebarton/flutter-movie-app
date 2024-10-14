import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.image, required this.title})
      : super(key: key);
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 12.0/6.0,
            child: SizedBox(
              width: double.infinity,
              child: Image(
                image: NetworkImage(image),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(40.0),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
