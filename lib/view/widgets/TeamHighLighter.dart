import 'package:flutter/material.dart';

import '../../model/domain/Team.dart';

class Teamhighlighter extends StatefulWidget {
  const Teamhighlighter({super.key, required this.team, required this.number});

  final Team team;
  final int number;

  @override
  State<Teamhighlighter> createState() => _TeamhighlighterState();
}

class _TeamhighlighterState extends State<Teamhighlighter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            Text("Team ${widget.number}",
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.lightGreen,
              ),
              child: SizedBox(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (widget.team.count > 0) {
                            widget.team.count--;
                            widget.team.controller.text =
                                widget.team.count.toString();
                          }
                        });
                      },
                    ),
                    Container(
                      color: Colors.grey[300],
                      height: 150,
                      width: 60,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 70.0,
                        child: TextField(
                          style: const TextStyle(
                            fontSize: 33.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          controller: widget.team.controller,
                          textAlign: TextAlign.center,
                          enabled: false,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          widget.team.count++;
                          widget.team.controller.text =
                              widget.team.count.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
