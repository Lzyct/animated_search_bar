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
  String searchText = '';
  final TextEditingController _controller =
      TextEditingController(text: 'Initial Text');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: AnimatedSearchBar(
              label: 'Search Something Here',
              controller: _controller,
              labelStyle: const TextStyle(fontSize: 16),
              searchStyle: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
              searchDecoration: const InputDecoration(
                hintText: 'Search',
                alignLabelWithHint: true,
                fillColor: Colors.white,
                focusColor: Colors.white,
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                debugPrint('value on Change');
                setState(() {
                  searchText = value;
                });
              },
              onFieldSubmitted: (value) {
                debugPrint('value on Field Submitted');
                setState(() {
                  searchText = value;
                });
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AnimatedSearchBar(
                label: 'Search Something Here',
                onChanged: (value) {
                  debugPrint('value on Change');
                  setState(() {
                    searchText = value;
                  });
                },
              ),
              Text(
                searchText,
                style: const TextStyle(fontSize: 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}
