// ignore_for_file: prefer_const_constructors_in_immutables, camel_case_types, must_be_immutable, non_constant_identifier_names, sort_child_properties_last
import 'dart:convert';
import 'dart:math';

import "package:http/http.dart" as http;

import 'package:flutter/material.dart';

class reviewScreen extends StatefulWidget {
  // List<Map<dynamic, dynamic>> reviewIds;
  String ImdbId;

  reviewScreen({required this.ImdbId, super.key});

  @override
  State<reviewScreen> createState() => _reviewScreenState();
}

class _reviewScreenState extends State<reviewScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool _loading = true;
  Future<void> findReview(String imdbId) async {
    String url =
        "https://movie-review-3gg6.onrender.com/api/reviews/findByImdbId/${widget.ImdbId}";
    final response = await http.get(Uri.parse(url));
    var responseData = jsonDecode(response.body);
    List<Map<String, dynamic>> m = [];
    for (var i in responseData) {
      m.add(i);
    }
    setState(() {
      reviews = m;
      _loading = false;
    });
  }

  List<Map<String, dynamic>> reviews = [];

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(
            child: CircularProgressIndicator(color: Colors.redAccent),
          )
        : ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, position) {
              return Card(
                child: Column(children: [
                  CircleAvatar(
                    child: Text(
                      reviews[position]["userId"][0],
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    backgroundColor: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                  ),
                  Text(
                    reviews[position]["userId"]!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 14),
                  ),
                  Text(
                    reviews[position]["body"]!,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                        color: Colors.grey[800]),
                  )
                ]),
              );
            });
  }
}
