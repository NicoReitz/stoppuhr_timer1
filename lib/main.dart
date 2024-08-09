import 'package:flutter/material.dart';
import 'package:stoppuhr_timer/stop_watch.dart';
void main() {
  runApp(TimerStopwatchApp());
}
class TimerStopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer & Stoppuhr',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimerStopwatchHomePage(),
    );
  }
}