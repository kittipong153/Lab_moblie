import 'package:flutter/material.dart';
import 'package:mobile_app/form_widget/form_simple.dart';
import 'package:mobile_app/form_widget/registration_form.dart';
import 'package:mobile_app/form_widget/temp_air.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AQIPage(),
    );
  }
}