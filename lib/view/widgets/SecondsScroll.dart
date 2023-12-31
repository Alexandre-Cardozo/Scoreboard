import 'package:flutter/material.dart';

class SecondsScroll extends StatelessWidget {
  final int secs;

  const SecondsScroll({super.key, required this.secs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Text(
          secs < 10 ? '0$secs' : secs.toString(),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
