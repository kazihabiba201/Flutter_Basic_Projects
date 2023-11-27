
import 'package:flutter/material.dart';
import 'googleMapScreen.dart';

void main() {
  runApp(const GoogleMapApp());
}

class GoogleMapApp extends StatelessWidget {
  const GoogleMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleMapScreen(),
    );
  }
}
