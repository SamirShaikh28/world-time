import 'package:flutter/material.dart';
import 'package:world_time/pages/Home.dart';
import 'package:world_time/pages/Loading.dart';
import 'package:world_time/pages/LocationScreen.dart';


void main() => runApp(MaterialApp(
  initialRoute: '/location',
  routes: {
    '/': (context) => LoadingScreen(),
    '/home': (context) => Home(),
    '/location': (context) => LocationScreen()
  }
));

