import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Hello World")),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              section("One!", Colors.red),
              section("One!", Colors.blue),
              section("One!", Colors.green),
            ]));
  }

  Widget section(String title, Color color) {
    return Container(
      decoration: BoxDecoration(color: color),
      child: const Text("one"),
    );
  }
}
