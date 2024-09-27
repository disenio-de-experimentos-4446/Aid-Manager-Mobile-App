import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; //font awesome
import 'dart:convert'; //JSON
import 'package:url_launcher/url_launcher.dart';
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

  @override
  void dispose() {
    // evitar llamar a setState luego de que el widget haya sido desmontado.
    super.dispose();
  }

  Future<void> fetchTeamMembers() async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=15'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (mounted) {
        setState(() {
          teamMembers = data['results'];
          isLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      throw Exception('Error al cargar los datos de la API');
    }
  }

  void launchWhatsApp(String phoneNumber) async {
    // Limpiamos el numero
    String cleanedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    //abrimos la url a whatsapp
    final url = 'https://wa.me/$cleanedNumber';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: teamMembers.length,
              itemBuilder: (context, index) {
                //Muestra todos los miembros del equipo dentro del arreglo teamMembers
                final member = teamMembers[index];
                return ListTile(
                  //Foto del miembro del equipo
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(member['picture']['thumbnail']),
                  ),
                  //Nombre
                  title: Text(
                      '${member['name']['first']} ${member['name']['last']}'),
                  //Telefono
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(member['phone']),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons
                            .whatsapp), // Icono de FontAwesome WhatsApp
                        onPressed: () {
                          launchWhatsApp(member['cell']);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
