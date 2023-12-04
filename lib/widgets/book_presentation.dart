import 'package:flutter/material.dart';

class BookPresentantion extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  const BookPresentantion(
      {super.key,
      required this.image,
      required this.title,
      required this.author});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.grey.shade50,
        elevation: 1.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              image.isNotEmpty
                  ? Image.network(
                      image,
                      height: 180,
                      width: 120,
                      fit: BoxFit.fill,
                    )
                  : const CircularProgressIndicator(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.black87),
                ),
              ),
              Expanded(
                child: Text(
                  author,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            ],
          ),
        ));
  }
}
