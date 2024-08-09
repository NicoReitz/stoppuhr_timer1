import 'dart:async';
import 'package:flutter/material.dart';

class TimerStopwatchHomePage extends StatefulWidget {
  @override
  _TimerStopwatchHomePageState createState() => _TimerStopwatchHomePageState();
}
class _TimerStopwatchHomePageState extends State<TimerStopwatchHomePage> {
  bool isTimerRunning = false;
  bool isStopwatchRunning = false;
  int timerDuration = 0;
  int remainingTime = 0;
  int stopwatchTime = 0;
  Timer? timer;
  // Controller for the text field input
  final TextEditingController _controller = TextEditingController();
  void startTimer() {
    if (!isTimerRunning && timerDuration > 0) {
      setState(() {
        remainingTime = timerDuration;
        isTimerRunning = true;
      });
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (remainingTime > 0) {
            remainingTime--;
          } else {
            timer.cancel();
            isTimerRunning = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Timer abgelaufen!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        });
      });
    }
  }
  void stopTimer() {
    if (isTimerRunning) {
      timer?.cancel();
      setState(() {
        isTimerRunning = false;
      });
    }
  }
  void startStopwatch() {
    if (!isStopwatchRunning) {
      setState(() {
        isStopwatchRunning = true;
      });
      timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        setState(() {
          stopwatchTime += 100;
        });
      });
    }
  }
  void stopStopwatch() {
    if (isStopwatchRunning) {
      timer?.cancel();
      setState(() {
        isStopwatchRunning = false;
      });
    }
  }
  void resetStopwatch() {
    stopStopwatch();
    setState(() {
      stopwatchTime = 0;
    });
  }
  @override
  void dispose() {
    timer?.cancel();
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer & Stoppuhr'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timer Section
            Text(
              'Timer',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Timer-Dauer in Sekunden eingeben',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  timerDuration = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 10),
            Text(
              'Verbleibende Zeit: ${remainingTime ~/ 60}:${(remainingTime % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: startTimer,
                  child: Text('Starten'),
                ),
                ElevatedButton(
                  onPressed: stopTimer,
                  child: Text('Stoppen'),
                ),
              ],
            ),
            Divider(height: 40),
            // Stopwatch Section
            Text(
              'Stoppuhr',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Verstrichene Zeit: ${(stopwatchTime ~/ 60000).toString().padLeft(2, '0')}:${((stopwatchTime ~/ 1000) % 60).toString().padLeft(2, '0')}:${(stopwatchTime % 1000 ~/ 100).toString().padLeft(1, '0')}',
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: startStopwatch,
                  child: Text('Starten'),
                ),
                ElevatedButton(
                  onPressed: stopStopwatch,
                  child: Text('Stoppen'),
                ),
                ElevatedButton(
                  onPressed: resetStopwatch,
                  child: Text('Zurücksetzen'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}