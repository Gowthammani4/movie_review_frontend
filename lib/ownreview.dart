// ignore_for_file: prefer_const_constructors_in_immutables, camel_case_types, must_be_immutable, non_constant_identifier_names, sort_child_properties_last
import 'dart:convert';

import "package:http/http.dart" as http;

import 'package:flutter/material.dart';

class ownreviewScreen extends StatefulWidget {
  ownreviewScreen({super.key});

  @override
  State<ownreviewScreen> createState() => _ownreviewScreenState();
}

class _ownreviewScreenState extends State<ownreviewScreen> {
  @override
  void initState() {
    super.initState();
    _findReview();
  }

  bool _loading = true;
  Future<void> _findReview() async {
    String url =
        "https://movie-review-3gg6.onrender.com/api/reviews/userReviews";
    final response = await http.get(Uri.parse(url));
    var responseData = jsonDecode(response.body);
    List<Map<String, dynamic>> m = [];
    for (var i in responseData) {
      m.add(i);
    }
    print(m);
    setState(() {
      reviews = m;
      _loading = false;
    });
  }

  List<Map<String, dynamic>> reviews = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Own Review",
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            )
          : reviews.isEmpty
              ? const Center(
                  child: Text("No reviews to show add new"),
                )
              : Column(
                  children: [
                    Container(
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                          itemCount: reviews.length,
                          itemBuilder: (context, position) {
                            return Card(
                              child: SizedBox(
                                height: 100,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                    ),
                  ],
                ),
    );
  }
}
