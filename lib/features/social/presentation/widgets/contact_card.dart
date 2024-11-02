import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String imageUrl;
  final String email;
  final String phone;
  final bool isDirector;
  final VoidCallback? onDelete;

  const ContactCard({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.phone,
    required this.email,
    this.isDirector = false,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          bottom: BorderSide(
            color: const Color.fromARGB(255, 201, 200, 200), // Color del borde inferior
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
              if (imageUrl.isNotEmpty && Uri.tryParse(imageUrl)?.hasAbsolutePath == true)
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
                  Row(
                    children: [
                      Text(
                        '$firstName $lastName',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isDirector)
                        Container(
                          margin: EdgeInsets.only(left: 8.0),
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            'Director',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
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
                icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 32.0),
                onPressed: () async {
                  final whatsappUrl = "https://wa.me/$phone";
                  if (await canLaunch(whatsappUrl)) {
                    await launch(whatsappUrl);
                  } else {
                    throw 'Could not launch $whatsappUrl';
                  }
                },
              ),
              if (onDelete != null)
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red, size: 32.0),
                  onPressed: onDelete,
                ),
            ],
          ),
        ],
      ),
    );
  }
}