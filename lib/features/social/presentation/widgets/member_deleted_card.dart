import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberDeletedCard extends StatefulWidget {
  final int userId;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final int age;
  final String email;
  final String phone;

  const MemberDeletedCard({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.phone,
    required this.email,
    required this.userId,
    required this.age,
  });

  @override
  State<MemberDeletedCard> createState() => _MemberDeletedCardState();
}

class _MemberDeletedCardState extends State<MemberDeletedCard> {
  Future<void> _sendMessageToMember(String number) async {
    final countryCode = '+51';
    final formattedNumber =
        number.startsWith('+') ? number : '$countryCode$number';
    final message = "Hi I'm from Aid Manager";
    final whatsappUrl =
        'https://wa.me/$formattedNumber?text=${Uri.encodeComponent(message)}';

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch WhatsApp')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: const Color.fromARGB(255, 201, 200, 200),
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
                ),
                child: ClipOval(
                  child: FadeInImage(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder:
                        AssetImage('assets/images/profile-placeholder.jpg'),
                    image: NetworkImage(widget.imageUrl),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/profile-placeholder.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.firstName} ${widget.lastName}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    widget.email,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.whatsapp,
                color: Colors.green, size: 30.0),
            onPressed: () {
              _sendMessageToMember(widget.phone);
            },
          ),
        ],
      ),
    );
  }
}