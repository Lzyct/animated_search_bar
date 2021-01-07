import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: AnimatedSearchBar(
            label: "Search Something Here",
            labelStyle: TextStyle(fontSize: 16),
            searchStyle: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            searchDecoration: InputDecoration(
              hintText: "Search",
              alignLabelWithHint: true,
              fillColor: Colors.white,
              focusColor: Colors.white,
              hintStyle: TextStyle(color: Colors.white70),
              border: InputBorder.none,
            ),
            onChanged: (value) {
              print("value on Change");
              setState(() {
                searchText = value;
              });
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              AnimatedSearchBar(
                label: "Search Something Here",
                onChanged: (value) {
                  print("value on Change");
                  setState(() {
                    searchText = value;
                  });
                },
              ),
              Text(
                searchText,
                style: TextStyle(fontSize: 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}
