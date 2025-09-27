import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          title: Text('CircleAvatar Stack Example'),
        ),
        body: Center(
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.lightGreen,
                radius: 100.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.yellow,
                    ),
                    Container(
                      height: 60.0,
                      width: 60.0,
                      color: Colors.amber,
                    ),
                    Container(
                      height: 40.0,
                      width: 40.0,
                      color: Colors.brown,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}