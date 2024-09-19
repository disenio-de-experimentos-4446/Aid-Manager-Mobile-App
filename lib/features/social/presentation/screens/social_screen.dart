import 'package:flutter/material.dart';

class SocialScreen extends StatelessWidget {
  static const String name = "social_screen";

  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const SocialContent(),
        );
      },
    );
  }
}

class SocialContent extends StatelessWidget {
  const SocialContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social'),
      ),
      body: const Center(
        child: Text(
          'Social Content',
          style: TextStyle(color: Colors.black, fontSize: 24.0),
        ),
      ),
    );
  }
}