import 'package:aidmanager_mobile/features/social/presentation/widgets/delete_member_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  final int userId;
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
    this.onDelete, required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(userId.toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return DeleteMemberDialog(
              onConfirm: () {
                Navigator.of(context).pop(true);
              },
            );
          },
        );
      },
      onDismissed: (direction) {
        if (onDelete != null) {
          onDelete!();
        }
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30.0,
        ),
      ),
      child: Container(
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
                      placeholder: AssetImage('assets/images/profile-placeholder.jpg'),
                      image: NetworkImage(imageUrl),
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
      ),
    );
  }
}