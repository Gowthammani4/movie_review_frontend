// ignore_for_file: unused_local_variable

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'main_app.dart';

void main() async {
  await _allmovies();
  runApp(const MyApp());
}

Future<void> _allmovies() async {
  String url = "https://movie-review-3gg6.onrender.com/api/movies";
  final response = await http.get(Uri.parse(url));
}
