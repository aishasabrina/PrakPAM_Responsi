import 'package:flutter/material.dart';
import 'package:responsiprakpam/list_matches.dart';

// Aisha Sabrina Ayundatama
// 124200056

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PIALA DUNIA 2022',
      theme: ThemeData(),
      home: ListMatches(),
    );
  }
}
