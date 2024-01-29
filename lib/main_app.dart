import 'package:Movie_reviews_App/ui/home.dart';
import 'package:flutter/material.dart';
import 'ui/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
      ),
      home: Login(),
    );
  }
}
