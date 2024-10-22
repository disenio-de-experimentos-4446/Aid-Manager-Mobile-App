import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String email;
  final String phone;

  const ContactCard(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.imageUrl,
      required this.phone,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          bottom: BorderSide(
            color: const Color.fromARGB(
                255, 201, 200, 200), // Color del borde inferior
            width: 1.0, // Ancho del borde inferior
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 52.0,
                height: 52.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$firstName $lastName',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: FaIcon(FontAwesomeIcons.whatsapp,
                    color: Colors.green, size: 32.0),
                onPressed: () {
                  // Acción de llamada
                },
              ),
              SizedBox(width: 5.0),
              IconButton(
                icon: Icon(Icons.message_outlined,
                    color: Colors.blue, size: 32.0),
                onPressed: () {
                  // Acción de mensaje
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
