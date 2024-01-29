// ignore_for_file: prefer_const_constructors_in_immutables, camel_case_types, must_be_immutable, non_constant_identifier_names, sort_child_properties_last, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps
import 'dart:convert';
import 'dart:math';

import "package:http/http.dart" as http;

import 'package:flutter/material.dart';
import '/ui/addreview.dart';

class reviewScreen extends StatefulWidget {
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
  var currentUser;

  Future<void> deleteReview(String imdbId) async {
    String url =
        "https://movie-review-3gg6.onrender.com/api/reviews/delete/${imdbId}";
    var response = await http.delete(Uri.parse(url));
    print(response);
  }

  Future<void> findReview(String imdbId) async {
    String url =
        "https://movie-review-3gg6.onrender.com/api/reviews/findByImdbId/${imdbId}";
    var currentUser_url = 'https://movie-review-3gg6.onrender.com/currentUser';

    final response = await http.post(Uri.parse(url));
    final res = await http.get(Uri.parse(currentUser_url));
    var resBody = jsonDecode(res.body);
    var responseData = jsonDecode(response.body);
    List<Map<String, dynamic>> m = [];
    for (var i in responseData) {
      m.add(i);
    }
    setState(() {
      currentUser = resBody;
      reviews = m;
      _loading = false;
    });
  }

  List<Map<String, dynamic>> reviews = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return addreview(imdb: widget.ImdbId);
            })),
            icon: const Icon(Icons.add),
          )
        ],
        title: const Text("Review Screen"),
        elevation: 0,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            )
          : reviews.isEmpty
              ? RefreshIndicator(
                  onRefresh: () => findReview(widget.ImdbId),
                  child: const Center(
                    child: Text("No reviews to show click + to add"),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () => findReview(widget.ImdbId),
                  child: Container(
                    color: Colors.black,
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                        itemCount: reviews.length,
                        itemBuilder: (context, position) {
                          return Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Colors.white,
                            shadowColor: Colors.blueGrey,
                            margin: const EdgeInsets.all(5),
                            child: SizedBox(
                              height: 50,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          reviews[position]["body"]!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.grey[800]),
                                        )
                                      ],
                                    ),
                                    reviews[position]["userId"] ==
                                            currentUser["userId"]
                                        ? IconButton(
                                            onPressed: () =>
                                                deleteReview(widget.ImdbId),
                                            icon: const Icon(
                                                Icons.delete_outline))
                                        : const SizedBox(
                                            width: 2,
                                          )
                                  ]),
                            ),
                          );
                        }),
                  ),
                ),
    );
  }
}
