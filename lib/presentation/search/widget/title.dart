import 'package:flutter/material.dart';

class SearchTitle extends StatelessWidget {
  const SearchTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22),
      textAlign: TextAlign.left,
    );
  }
}
