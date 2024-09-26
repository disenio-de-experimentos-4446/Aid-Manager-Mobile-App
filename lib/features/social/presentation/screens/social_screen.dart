import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; //font awesome
import 'dart:convert'; //JSON
import 'package:http/http.dart' as http;

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
//cambiamos a StatefulWidget para actualizar el estado
//debido a que el API maneja datos dinamicos
class SocialContent extends StatefulWidget {
  const SocialContent({super.key});

  //maneja los cambnios del widget
  @override
  _SocialContentState createState() => _SocialContentState();
}
class _SocialContentState extends State<SocialContent> {
  List<dynamic> teamMembers = []; //se almacenan los teamMembers
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTeamMembers();
  }
  //get del API
  Future<void> fetchTeamMembers() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/?results=15'));
    //try
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        teamMembers = data['results'];
        isLoading = false;
      });
      //catch
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Error al cargar los datos de la API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Team',
          style: TextStyle(color: Colors.black, fontSize: 24.0),
        ),
      ),
    );
  }
}
