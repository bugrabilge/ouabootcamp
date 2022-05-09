import 'package:flutter/material.dart';
import 'package:bootcamp/Anasayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      initialRoute: Anasayfa.id,
      routes: {
        Anasayfa.id: (context) => const Anasayfa(),
      },
    );
  }
}