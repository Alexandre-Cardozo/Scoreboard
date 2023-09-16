import 'package:flutter/material.dart';
import 'package:scoreboard/view/widgets/AnimatedButton.dart';
import 'package:scoreboard/view/widgets/CircularCountdown.dart';
import 'package:scoreboard/view/widgets/MatchTimeSetter.dart';
import 'package:scoreboard/view/widgets/TeamHighLighter.dart';

import '../model/domain/Countdown.dart';
import '../model/domain/Team.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(title: 'Scoreboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Team teamOne = Team();
  Team teamTwo = Team();

  Countdown countdown = Countdown();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Center(
            child: Text(
          widget.title!,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              MatchTimeSetter(countdown: countdown),
              CircularCountdown(countdown: countdown),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Teamhighlighter(team: teamOne, number: 1),
                  const SizedBox(
                    width: 10,
                  ),
                  Teamhighlighter(team: teamTwo, number: 2),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: AnimatedButton(
          countdown: countdown, teamOne: teamOne, teamTwo: teamTwo),
    );
  }
}
