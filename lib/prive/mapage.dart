import 'package:flutter/material.dart';

class Mapage extends StatefulWidget {
  const Mapage({super.key});

  @override
  State<Mapage> createState() => _MapageState();
}

class _MapageState extends State<Mapage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('page protegee'),
      ),
      body: const Column(
        children: [
          Center(child: Text('bonjour dans la page protegee')),
        ],
      ),
    );
  }
}
