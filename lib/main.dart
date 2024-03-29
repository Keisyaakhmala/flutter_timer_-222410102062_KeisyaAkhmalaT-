import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timer App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Timer App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  bool _isTimerRunning = false;
  TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  Widget _buildTimerText(int value) {
    String text = value.toString().padLeft(2, '0');
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.orange,
      ),
      padding: EdgeInsets.all(20),
      child: Text(
        text,
        style: TextStyle(fontSize: 48, color: Colors.white),
      ),
    );
  }

  Widget _buildTimeSeparators() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        '',
        style: TextStyle(fontSize: 48, color: Colors.orange),
      ),
    );
  }

  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
      _hours = int.parse(_timeController.text.split('')[0]);
      _minutes = int.parse(_timeController.text.split('')[1]);
      _seconds = int.parse(_timeController.text.split('')[2]);
    });

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        if (_minutes == 0) {
          if (_hours == 0) {
            timer.cancel();
            _showAlertDialog();
          } else {
            _hours--;
            _minutes = 59;
            _seconds = 59;
          }
        } else {
          _minutes--;
          _seconds = 59;
        }
      } else {
        _seconds--;
      }

      setState(() {});
    });
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
  }

  void _resetTimer() {
    setState(() {
      _hours = 0;
      _minutes = 0;
      _seconds = 0;
      _isTimerRunning = false;
      _timeController.clear();
    });
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Waktu Habis!'),
          content: Text('Timer telah selesai.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _resetTimer();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'NIM: 222410102062',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Nama: Keisya Akhmala T',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Waktu Tersisa:',
              style: TextStyle(fontSize: 24),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTimerText(_hours),
                _buildTimeSeparators(),
                _buildTimerText(_minutes),
                _buildTimeSeparators(),
                _buildTimerText(_seconds),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: _isTimerRunning ? null : _startTimer,
                  child: Text(
                    'Mulai',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: _isTimerRunning ? _stopTimer : null,
                  child: Text(
                    'Berhenti',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: _resetTimer,
                  child: Text(
                    'Mulai Ulang',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Masukkan Waktu:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 20),
                Flexible(
                  child: TextField(
                    controller: _timeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(8)],
                    decoration: InputDecoration(
                      labelText: 'Jam Menit Detik',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
