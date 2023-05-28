// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


class BuildButton extends StatelessWidget {
  BuildButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onClicked});

  String title;
  IconData icon;
  VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            textStyle: const TextStyle(fontSize: 20)),
        onPressed: onClicked,
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}
