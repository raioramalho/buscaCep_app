import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'app/pages/home.dart';

void main() async {
  runApp(MaterialApp(
    home: const Home(),
    theme: ThemeData(
        hintColor: Colors.deepPurple,
        primaryColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple)),
          hintStyle: TextStyle(color: Colors.deepPurple),
        )),
  ));
}

Future<Map> getData(String cep) async {
  if (cep.isEmpty) {
    cep = '01001000';
  } else {
    cep = cep;
  }
  var httpsUri =
      Uri(scheme: 'https', host: 'cep.awesomeapi.com.br', path: 'json/$cep');
  http.Response res = await http.get(httpsUri);
  return json.decode(res.body);
}
