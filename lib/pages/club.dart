import 'package:flutter/material.dart';

class Club extends StatelessWidget {
  const Club({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club')),
      body: const Center(
        child: Text(
          'This is the Club Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
