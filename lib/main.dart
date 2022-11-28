import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'QR Code'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final baseURL = 'https://jsonplaceholder.typicode.com/posts';
  var _setData = [];

  void fetchData() async {
    try {
      final response = await get(Uri.parse(baseURL));
      final post = jsonDecode(response.body) as List;

      setState(() {
        _setData = post;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _setData.length,
        itemBuilder: (context, i){
          final datas = _setData[i];
          return Text('Title : ${datas['title']}');
        },
      ),
    );
  }
}
