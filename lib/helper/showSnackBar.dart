import 'package:flutter/material.dart';

void showSnakBar(BuildContext context , String messge) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(messge),
      ));
}
