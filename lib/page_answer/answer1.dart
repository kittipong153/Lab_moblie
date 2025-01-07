import 'package:flutter/material.dart';

class Answer1 extends StatelessWidget {
  const Answer1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grid Layout"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // แถวที่ 1
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
                const SizedBox(width: 20),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                ),
                const SizedBox(width: 20),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // แถวที่ 2
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.orange,
                ),
                const SizedBox(width: 20),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.purple,
                ),
                const SizedBox(width: 20),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.yellow,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
