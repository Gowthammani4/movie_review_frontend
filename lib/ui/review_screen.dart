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
    findReview(widget.ImdbId);
  }

  bool _loading = true;
  Future<void> findReview(String imdbId) async {
    String url =
        "https://movie-review-3gg6.onrender.com/api/reviews/findByImdbId/${imdbId}";
    final response = await http.post(Uri.parse(url));
    var responseData = jsonDecode(response.body);
    print(responseData);
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
        : reviews.isEmpty
            ? const Center(
                child: Text("No reviews to show"),
              )
            : Container(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, position) {
                      return Card(
                        child: Container(
                          height: 100,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  child: Text(
                                    reviews[position]["userId"][0],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  backgroundColor: Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      reviews[position]["userId"]!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      reviews[position]["body"]!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                          color: Colors.grey[800]),
                                    )
                                  ],
                                )
                              ]),
                        ),
                      );
                    }),
              );
  }
}
