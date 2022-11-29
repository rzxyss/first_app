import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// commit

void main() {
  runApp(MaterialApp(
    home: FirstApp(),
  ));
}

class Data {
  final String title;

  const Data({
    required this.title,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json['title'],
    );
  }
}

class FirstApp extends StatelessWidget {
  final String api = "https://fakestoreapi.com/users";
  Future<List<dynamic>> fecthDataUsers() async {
    var result = await http.get(Uri.parse(api));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FirstApp'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: fecthDataUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(snapshot.data[index]['email']),
                    ));
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
