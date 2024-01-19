// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

// import 'login.dart';

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

  List<Map<String, dynamic>> movies = [];

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login App"),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: IconButton(
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
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      // Theme.of(context).colorScheme.primary,
      body: movies.isEmpty
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
                                      Text(
                                        movies[position]["genres"].toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      // Column(
                                      //   children: [
                                      //     for (String i in movies[position]["genres"])
                                      //       Text(i)
                                      //   ],
                                      // ),
                                      // Text(movies[position]["reviews"].length()),
                                      const Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            clipBehavior: Clip.antiAlias,
                                            onPressed: null,
                                            child: Text("Play Trailer"),
                                          ),
                                          SizedBox(
                                            height: 20,
                                            width: 20,
                                          ),
                                          ElevatedButton(
                                              clipBehavior: Clip.hardEdge,
                                              onPressed: null,
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
