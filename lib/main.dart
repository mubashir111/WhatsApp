import 'package:flutter/material.dart';
import 'package:whatapp/sections/homepagelist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WhatsupHomePage(),
    );
  }
}

class WhatsupHomePage extends StatelessWidget {
  const WhatsupHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff128C7E),
        title: const Text('WhatsApp'),
      ),
      body: const HomepageListView(),
    );
  }
}
