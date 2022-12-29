// ignore_for_file: file_names
import 'package:flutter/material.dart';

Widget buildText(String label) {
  return SizedBox(
    height: 20,
    child: Row(children: [
      const Icon(
        Icons.local_activity_outlined,
        size: 20,
        color: Colors.deepPurple,
      ),
      Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    ]),
  );
}
