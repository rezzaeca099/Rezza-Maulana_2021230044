import 'package:flutter/material.dart';
import 'package:uas_rezza/screens/home_screen.dart';// Pastikan Anda mengimpor HomeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Atur HomeScreen sebagai tampilan awal
    );
  }
}
