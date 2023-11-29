import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:segunda_etapa_teste/models/book_model.dart';
import 'package:segunda_etapa_teste/widgets/book_presentation.dart';

import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class HttpTestePage extends StatefulWidget {
  const HttpTestePage({super.key});

  @override
  State<HttpTestePage> createState() => _HttpTestePageState();
}

class _HttpTestePageState extends State<HttpTestePage> {
  double? _progress;
  List<BookModel> _books = [];
  var url = "https://escribo.com/books.json";

  Future<List<BookModel>> fetchBooks() async {
    var response = await http.get(Uri.parse(url));

    var books = <BookModel>[];

    if (response.statusCode == 200) {
      var booksJson = json.decode(response.body);

      for (var bookJson in booksJson) {
        books.add(BookModel.fromJson(bookJson));
        print(books.length);
      }
    }
    return books;
  }

  @override
  void initState() {
    fetchBooks().then((value) {
      setState(() {
        _books.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2),
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.54, crossAxisCount: 3, mainAxisSpacing: 3),
          itemCount: _books.length,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              child: BookPresentantion(
                  image: _books[index].coverUrl.toString(),
                  title: _books[index].title.toString(),
                  author: _books[index].author.toString()),
              onTap: () {
                FileDownloader.downloadFile(
                    url: _books[index].downloadUrl.toString(),
                    onProgress: (name, progress) {
                      setState(() {
                        _progress = progress;
                      });
                    },
                    onDownloadCompleted: (value) {
                      print('path $value');
                      setState(() {
                        _progress = null;
                      });
                    });
              },
            );
          },
        ),
      ),
    );
  }
}
