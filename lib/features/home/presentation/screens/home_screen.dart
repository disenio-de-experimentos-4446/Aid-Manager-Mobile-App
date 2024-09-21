import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static const String name = "home_screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const HomeContent(),
        );  
      },
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Home Content',
          style: TextStyle(color: Colors.black, fontSize: 24.0),
        ),
      ),
    );
  }
}