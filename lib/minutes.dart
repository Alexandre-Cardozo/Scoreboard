import 'package:flutter/material.dart';

class MyMinutes extends StatelessWidget {
  final int mins;

  const MyMinutes({super.key, required this.mins});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Text(
          mins < 10 ? '0$mins' : mins.toString(),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
