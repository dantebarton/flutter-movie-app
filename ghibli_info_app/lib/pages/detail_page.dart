import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghibli_info_app/pages/trailer_screen_page.dart'; // Import Youtube player screen
import 'package:ghibli_info_app/album.dart'; // Import your Album model
import 'package:ghibli_info_app/services/trailer_service.dart'; // Import the trailer service
import 'package:youtube_player_flutter/youtube_player_flutter.dart'; // Import Youtube player


class DetailPage extends StatefulWidget {
  final Album album;

  const DetailPage({super.key, required this.album});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? trailerUrl; // Variable to hold the trailer URL
  final trailerService = TrailerService(
      'http://localhost:3000/api'); // Replace with your actual API URL

  @override
  void initState() {
    super.initState();
    _fetchTrailer(); // Fetch trailer when the page initializes
  }

  Future<void> _fetchTrailer() async {
    try {
      final url = await trailerService.fetchTrailer(widget.album.id);
      setState(() {
        trailerUrl =
            YoutubePlayer.convertUrlToId(url!); // Store the trailer URL
      });
    } catch (e) {
      log('Error fetching trailer: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.album.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 12.0 / 6.0,
              child: Image.network(
                widget.album.movieBanner,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child:
                        Icon(Icons.broken_image, size: 50, color: Colors.red),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   widget.album.title,
                  //   style: const TextStyle(
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  Text(
                    "Original Title: ${widget.album.originalTitle}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Romanized Title: ${widget.album.originalTitleRomanized}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Description:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.album.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Director: ${widget.album.director}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Producer: ${widget.album.producer}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Release Date: ${widget.album.releaseDate}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Running Time: ${widget.album.runningTime} minutes",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Rotten Tomatoes Score: ${widget.album.rtScore}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  // Button to watch trailer
                  if (trailerUrl != null)
                    ElevatedButton(
                      onPressed: () {
                        if (trailerUrl != null) {
                          // _playTrailer(trailerUrl!);
                           Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => YoutubePlayerScreen(videoId: trailerUrl!, title: widget.album.title),
                              ),
                            );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Trailer URL is not available')),
                          );
                        }
                      },
                      child: const Text('Watch Trailer'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
