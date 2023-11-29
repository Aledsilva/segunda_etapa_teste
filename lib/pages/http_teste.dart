import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:segunda_etapa_teste/models/book_model.dart';

class HttpTestePage extends StatefulWidget {
  const HttpTestePage({super.key});

  @override
  State<HttpTestePage> createState() => _HttpTestePageState();
}

class _HttpTestePageState extends State<HttpTestePage> {
  var response;

  void connectApi() async {
    print("Antes");
    response = await http.get(Uri.parse('https://escribo.com/books.json'));
    print("Depois");
    print(response.body);
    var json = jsonDecode(response.body);
    var booksModel = BookModel.fromJson(json[0]); // forEach e index
    print(booksModel.author);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.54, crossAxisCount: 3, mainAxisSpacing: 15),
          itemCount: 5,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.network(
                        "https://www.gutenberg.org/cache/epub/72134/pg72134.cover.medium.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    "The Bible of Nature",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black87),
                  ),
                  Text(
                    "Oswald, Felix L.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: (FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      )),
    ));
  }
}
