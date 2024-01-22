import 'package:flutter/material.dart';
import 'package:spring_boot_test/ui/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
      ),
      home: Home(),
    );
  }
}
