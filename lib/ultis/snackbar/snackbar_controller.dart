import 'package:flutter/material.dart';

class SnackBarController {
  void show({
    required BuildContext context,
    required String content,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      content: Text(
        content,
      ),
    ));
  }
}
