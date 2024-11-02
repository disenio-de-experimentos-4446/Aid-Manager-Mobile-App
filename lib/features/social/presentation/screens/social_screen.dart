import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/social/presentation/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; //JSON
import 'package:url_launcher/url_launcher.dart';
import "package:http/http.dart" as http;

class SocialScreen extends StatelessWidget {
  static const String name = "social_screen";

  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const SocialContentState(),
        );
      },
    );
  }
}

class SocialContentState extends StatefulWidget {
  const SocialContentState({super.key});

  @override
  State<SocialContentState> createState() => _SocialContentStateState();
}

class _SocialContentStateState extends State<SocialContentState> {
  List<dynamic> teamMembers = [];
  //se almacenan los teamMembers
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
          teamMembers = data["results"];
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey, // Color del borde
                    width: 1.0, // Ancho del borde
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 25.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .white, // Fondo blanco para el TextField
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 3), // Cambia la posición de la sombra
                                ),
                              ],
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search a contact',
                                prefixIcon: Icon(Icons.search),
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 12.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        TextButton(
                          onPressed: () {
                            // Acción del botón
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                CustomColors.darkGreen, // Color de fondo
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 8.0),
                          ),
                          child: Text(
                            'A - Z',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            isLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: ListView.builder(
                      itemCount: teamMembers.length,
                      itemBuilder: (context, index) {
                        final member = teamMembers[index];
                        return ContactCard(
                          firstName: member["name"]["first"],
                          lastName: member["name"]["last"],
                          imageUrl: member["picture"]["thumbnail"],
                          email: member["email"],
                          phone: member["phone"],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
