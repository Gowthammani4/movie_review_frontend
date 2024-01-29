// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_interpolation_to_compose_strings, unnecessary_null_comparison, unrelated_type_equality_checks

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/ownreview.dart';
import '/ui/review_screen.dart';
import '/ui/youtubeplayer.dart';

import 'login.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _allmovies();
  }

  String removeBeforeEquals(String text) {
    int equalsIndex = text.indexOf("=");
    if (equalsIndex != -1) {
      return text.substring(equalsIndex + 1);
    } else {
      return "";
    }
  }

  List<Map<String, dynamic>> movies = [];
  bool _loading = true;
  Future<void> _allmovies() async {
    String url = "https://movie-review-3gg6.onrender.com/api/movies";
    final response = await http.get(Uri.parse(url));
    var responseData = jsonDecode(response.body);
    List<Map<String, dynamic>> m = [];
    for (var i in responseData) {
      m.add(i);
    }
    setState(() {
      movies = m;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ownreviewScreen();
                    }));
                  },
                  icon: const Icon(Icons.person),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const Login();
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: _loading
          ? GestureDetector(
              onTap: () => setState(() {}),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.redAccent,
                ),
              ),
            )
          : GestureDetector(
              onTap: () => setState(() {}),
              child: Container(
                color: Colors.black,
                child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, position) {
                    return Container(
                      height: 300,
                      width: 300,
                      child: GestureDetector(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                    child: Image(
                                  image:
                                      NetworkImage(movies[position]["poster"]),
                                  height: 300,
                                  width: 200,
                                  fit: BoxFit.contain,
                                )),
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        movies[position]["title"],
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Genre: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            movies[position]["genres"]
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Release_Date: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          Text(
                                              movies[position]["releaseDate"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                  fontSize: 12)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            clipBehavior: Clip.antiAlias,
                                            onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return VideoPlayerScreen(
                                                      videoId: removeBeforeEquals(
                                                          movies[position]
                                                              ["trailerLink"]));
                                                },
                                              ),
                                            ),
                                            child: Text("Play Trailer"),
                                          ),
                                          SizedBox(
                                            height: 20,
                                            width: 20,
                                          ),
                                          ElevatedButton(
                                              clipBehavior: Clip.hardEdge,
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return reviewScreen(
                                                          ImdbId:
                                                              movies[position]
                                                                  ["imdbId"]);
                                                    },
                                                  ),
                                                );
                                              },
                                              child: Text("Reviews"))
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
