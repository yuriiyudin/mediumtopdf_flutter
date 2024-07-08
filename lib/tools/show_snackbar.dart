import 'package:flutter/material.dart';

showMessage(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(message, style: TextStyle(color: Colors.red, fontSize: 21),)),
    ),
  );
}
