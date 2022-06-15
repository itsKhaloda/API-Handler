import 'package:flutter/material.dart';
import 'package:iti_summer_course_tutorial/screens/home/home_screen.dart';

void main() {
  runApp(GetMyAppRootWidget());
}

class GetMyAppRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
