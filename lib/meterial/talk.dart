import 'package:flutter/material.dart';

class Talk extends StatelessWidget {
  const Talk({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Talk')),
      body: const Center(
        child: Text(
          'This is the Talk Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
