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
    var res = json.decode(response.body);
    List<Map<String, dynamic>> m = [];
    print("The res type is ${res.runtimeType}");
    for (var i in responseData) {
      m.add(i);
    }

    print("The type of response data ${responseData.runtimeType}");
    print("The type of m: ");
    print(m.runtimeType);
    print(m);
    movies = m;
    print(movies[3]["title"]);
    print(movies[0]["poster"]);
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
      body: GestureDetector(
        onTap: () => setState(() {}),
        child: Container(
          child: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, position) {
              return Container(
                height: 300,
                child: GestureDetector(
                  child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            ClipRRect(
                                child: Image(
                              image: NetworkImage(movies[position]["poster"]),
                              height: 300,
                              width: 200,
                              fit: BoxFit.contain,
                            )),
                            Container(
                              child: Row(
                                children: [
                                  Text(movies[position]["title"]),
                                  Text(movies[position]["genres"].toString()),
                                  // Column(
                                  //   children: [
                                  //     for (String i in movies[position]["genres"])
                                  //       Text(i)
                                  //   ],
                                  // ),
                                  // Text(movies[position]["reviews"].length()),
                                  const Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: null,
                                        child: Text("Play Trailer"),
                                      ),
                                      ElevatedButton(
                                          onPressed: null,
                                          child: Text("Reviews"))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
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
