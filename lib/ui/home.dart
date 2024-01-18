import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() async {
    movies = await allmovies();
    super.initState();
  }

  List<Map<String, dynamic>> movies = [];
  Future<List<Map<String, dynamic>>> allmovies() async {
    String url = "https://movie-review-3gg6.onrender.com/api/movies";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    return responseData;
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
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, position) {
            return GestureDetector(
              onTap: null,
              child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        ClipRRect(
                            child: Image(
                          image: NetworkImage(movies[position]["poster"]!),
                          height: 300,
                          width: 200,
                          fit: BoxFit.contain,
                        )),
                        Row(
                          children: [
                            Text(movies[position]["title"]!),
                            Column(
                              children: [
                                for (String i in movies[position]["genres"]!)
                                  Text(i)
                              ],
                            ),
                            Text(movies[position]["reviews"]!.length()),
                            const Column(
                              children: [
                                ElevatedButton(
                                  onPressed: null,
                                  child: Text("Play Trailer"),
                                ),
                                ElevatedButton(
                                    onPressed: null, child: Text("Reviews"))
                              ],
                            )
                          ],
                        )
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
