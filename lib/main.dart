import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const TrafficLightApp());
}

class TrafficLightApp extends StatelessWidget {
  const TrafficLightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrafficLightScreen(),
    );
  }
}

class TrafficLightScreen extends StatefulWidget {
  @override
  _TrafficLightScreenState createState() => _TrafficLightScreenState();
}

class _TrafficLightScreenState extends State<TrafficLightScreen> {
  int _currentLight = 0;
  int _seconds = 15;
  Timer? _timer;

  final List<String> _messages = [
    'หยุด',
    'ระวัง',
    'ไปได้'
  ];

  final List<Color> _lightColors = [
    Colors.red,
    Colors.yellow,
    Colors.green
  ];

  final List<int> _lightDurations = [
    15, // ไฟแดง 15 วินาที
    3,  // ไฟเหลือง 3 วินาที
    10  // ไฟเขียว 10 วินาที
  ];

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = _lightDurations[_currentLight];
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 1) {
        setState(() {
          _seconds--;
        });
      } else {
        timer.cancel();
        _changeLight();
      }
    });
  }

  void _changeLight() {
    setState(() {
      _currentLight = (_currentLight + 1) % 3;
    });
    _startTimer();
  }

  double _getOpacity(int lightIndex) {
    return _currentLight == lightIndex ? 1.0 : 0.3;
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Traffic Light Animation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _getOpacity(0),
              child: _buildLight(Colors.red),
            ),
            const SizedBox(height: 10),
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _getOpacity(1),
              child: _buildLight(Colors.yellow),
            ),
            const SizedBox(height: 10),
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _getOpacity(2),
              child: _buildLight(Colors.green),
            ),
            const SizedBox(height: 20),
            Text(
              '${_messages[_currentLight]} ($_seconds วินาที)',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeLight,
              child: const Text('เปลี่ยนไฟ'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLight(Color color) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
