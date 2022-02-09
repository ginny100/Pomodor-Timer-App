import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _seconds = 0;
  int _minutes = 25;
  Timer _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    print("Timer Initialized");
  });
  var f = NumberFormat("00");

  void _startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    if (_minutes > 0) {
      _seconds = _minutes * 60;
    }
    if (_seconds > 60) {
      _minutes = (_seconds / 60).floor();
      _seconds -= (_minutes * 60);
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          if (_minutes > 0) {
            _seconds = 59;
            _minutes--;
          } else {
            _timer.cancel();
            print("Timer Complete");
          }
        }
      });
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer.cancel();
      _seconds = 0;
      _minutes = 25;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      // image: NetworkImage(
      //     'https://www.pinclipart.com/picdir/middle/563-5636313_transparent-background-cute-clock-clipart-png-download.png'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${f.format(_minutes)} : ${f.format(_seconds)}",
                style: TextStyle(
                  color: Colors.pink[50],
                  fontSize: 70,
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: 300,
          // ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Image.asset(
              'images/alarm-clock.png',
              height: 400,
              width: 400,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () {
                  _startTimer();
                },
                color: Colors.red[100],
                shape: CircleBorder(
                  side: BorderSide(color: Colors.red),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    "Start",
                    style: TextStyle(
                      color: Colors.red[400],
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _stopTimer();
                  });
                },
                color: Colors.red[400],
                shape: CircleBorder(
                  side: BorderSide(color: Colors.red),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    "Stop",
                    style: TextStyle(
                      color: Colors.pink[100],
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
