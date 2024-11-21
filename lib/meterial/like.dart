import 'package:flutter/material.dart';

class Like extends StatelessWidget {
  const Like({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Like')),
      body: const Center(
        child: Text(
          'This is the Like Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
