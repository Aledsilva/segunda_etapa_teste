import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:segunda_etapa_teste/models/book_model.dart';
import 'package:segunda_etapa_teste/widgets/book_presentation.dart';

import 'package:flutter_file_downloader/flutter_file_downloader.dart';

import 'package:path_provider/path_provider.dart';

class LibraryHomePage extends StatefulWidget {
  const LibraryHomePage({super.key});

  @override
  State<LibraryHomePage> createState() => _LibraryHomePageState();
}

class _LibraryHomePageState extends State<LibraryHomePage> {
  String downloadMessage = "Iniciando...";
  bool _isDownloading = false;
  double? _percentage;

  Dio dio = Dio();

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
        backgroundColor: Colors.cyanAccent.shade200,
        title: const Text("Estante Virtual"),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(2),
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7, crossAxisCount: 2, mainAxisSpacing: 5),
          itemCount: _books.length,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              child: BookPresentantion(
                image: _books[index].coverUrl.toString(),
                title: _books[index].title.toString(),
                author: _books[index].author.toString(),
              ),
              onTap: () async {
                setState(() {
                  _isDownloading = true;
                });

                //TODO remover a função daqui e apenas chama-la
                var dir = await getExternalStorageDirectory();
                dio.download(
                    _books[index].downloadUrl.toString(), '${dir?.path}/sample',
                    onReceiveProgress: (actualBytes, totalBytes) {
                  _percentage = actualBytes / totalBytes * 100;
                  setState(() {
                    downloadMessage = '${_percentage?.floor().toString()} %';
                    _percentage?.toInt();
                  });

                  //TODO Exibir o download, ou na grid ou em uma dialog
                  print(
                      '${_books[index].title} : Downloading... $_percentage %');
                });
              },
            );
          },
        ),
      ),
    );
  }
}
