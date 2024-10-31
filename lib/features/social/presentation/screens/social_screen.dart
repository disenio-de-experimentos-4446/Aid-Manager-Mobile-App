import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/social/presentation/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aidmanager_mobile/features/social/presentation/screens/social_provider.dart';

import '../../../auth/presentation/providers/auth_provider.dart';

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
  @override
  void initState() {
    super.initState();
    context.read<SocialProvider>().getMembersByCompany();
  }

  @override
  Widget build(BuildContext context) {
    final socialProvider = context.watch<SocialProvider>();
    final authProvider = context.watch<AuthProvider>();
    final isDirector = authProvider.user?.role == 'Manager';

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
                              color: Colors.white, // Fondo blanco para el TextField
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // Cambia la posición de la sombra
                                ),
                              ],
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search a contact',
                                prefixIcon: Icon(Icons.search),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 12.0),
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
                            backgroundColor: CustomColors.darkGreen, // Color de fondo
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
            socialProvider.isLoading
                ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Center(child: CircularProgressIndicator()))
                : Expanded(
              child: ListView.builder(
                itemCount: socialProvider.users.length,
                itemBuilder: (context, index) {
                  final member = socialProvider.users[index];
                  final nameParts = member.name.split(' ');
                  final firstName = nameParts.isNotEmpty ? nameParts[0] : '';
                  final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

                  return ContactCard(
                    firstName: firstName,
                    lastName: lastName,
                    imageUrl: member.profileImg ?? '',
                    email: member.email,
                    phone: member.phone ?? '',
                    isDirector: member.role == 'Manager',
                    onDelete: isDirector
                        ? () => socialProvider.kickMemberFromCompany(member.id!)
                        : null,
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