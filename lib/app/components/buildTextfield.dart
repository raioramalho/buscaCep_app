import 'dart:ffi';

import 'package:flutter/material.dart';

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  void _onSubmitted(String text) {
    f(text);
  }

  return TextField(
    controller: c,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(),
      prefixText: prefix,
      prefixStyle: TextStyle(color: Colors.white),
    ),
    style: TextStyle(color: Colors.white),
    onSubmitted: _onSubmitted,
  );
}
