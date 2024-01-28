// ignore_for_file: avoid_print, unnecessary_null_comparison, use_build_context_synchronously, unrelated_type_equality_checks, camel_case_types, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class addreview extends StatefulWidget {
  String imdb;
  addreview({
    required this.imdb,
    Key? key,
  }) : super(key: key);

  @override
  State<addreview> createState() => _addreviewState();
}

class _addreviewState extends State<addreview> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _controllerreview = TextEditingController();
  String reviewBody = "";

  Future<String> _sendreview(String reviewBody, String imdb) async {
    String url = "https://movie-review-3gg6.onrender.com/api/reviews";
    final response = await http.post(Uri.parse(url),
        body: json.encode({"reviewBody": reviewBody, "imdbId": imdb}),
        headers: {'Content-Type': 'application/json'});
    print(response.body);
    var res = response.body.toString();
    if (res == "Success") {
      return "Success";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 150),
              Text(
                "Add a review",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 60),
              TextFormField(
                onFieldSubmitted: (value) => reviewBody = value,
                controller: _controllerreview,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: "Review",
                  prefixIcon: const Icon(Icons.comment_bank),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a review.";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 60),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      reviewBody = _controllerreview.text;
                      if (_formKey.currentState?.validate() ?? false) {
                        var a = await _sendreview(reviewBody, widget.imdb);
                        a == "Success"
                            ? Navigator.pop(context)
                            : {_formKey.currentState?.reset(), setState(() {})};
                      }
                    },
                    child: const Text("Post"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerreview.dispose();
    super.dispose();
  }
}
