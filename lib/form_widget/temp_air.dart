import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AQIPage(),
    );
  }
}

class AQIPage extends StatefulWidget {
  @override
  _AQIPageState createState() => _AQIPageState();
}

class _AQIPageState extends State<AQIPage> {
  String city = "Bangkok";
  int aqi = 0;
  double temperature = 0.0;
  bool isLoading = false;

  Future<void> fetchAQI() async {
    setState(() {
      isLoading = true;
    });

    final String token = "a70d23b1ac7175c25b9a4f9d663c91393eb7108a";
    final String url = "https://api.waqi.info/feed/here/?token=a70d23b1ac7175c25b9a4f9d663c91393eb7108a";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          aqi = data['data']['aqi'];
          temperature = data['data']['iaqi']['t']['v'].toDouble();
        });
      }
    } catch (e) {
      print("Error: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAQI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Air Quality Index (AQI)")),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(city, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: aqi > 100 ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "$aqi",
                      style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    aqi > 100 ? "Unhealthy" : "Good",
                    style: TextStyle(fontSize: 25, color: aqi > 100 ? Colors.red : Colors.green, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text("Temperature: ${temperature.toStringAsFixed(1)}°C", style: TextStyle(fontSize: 18)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: fetchAQI,
                    child: Text("Refresh"),
                  )
                ],
              ),
      ),
    );
  }
}
