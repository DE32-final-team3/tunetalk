import 'package:flutter/material.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Playlist')),
      body: const Center(
        child: Text(
          'This is the Playlist Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
