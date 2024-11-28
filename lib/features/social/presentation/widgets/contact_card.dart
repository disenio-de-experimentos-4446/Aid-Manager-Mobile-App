import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/social/presentation/widgets/delete_member_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatefulWidget {
  final int userId;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final int age;
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
    required this.userId,
    required this.age,
  });

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  bool _isDismissed = false;

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
    return _isDismissed
        ? Container()
        : Dismissible(
            key: Key(widget.userId.toString()),
            direction: widget.isDirector
                ? DismissDirection.none
                : DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              final result = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return DeleteMemberDialog(
                    onConfirm: () {
                      Navigator.of(context).pop(true);
                    },
                  );
                },
              );
              return result;
            },
            onDismissed: (direction) {
              setState(() {
                _isDismissed = true;
              });
              widget.onDelete?.call();
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 28.0,
              ),
            ),
            child: Container(
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
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: FadeInImage(
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: AssetImage(
                          'assets/images/profile-placeholder.jpg',
                        ),
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
                  SizedBox(width: 12.0),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${widget.firstName} ${widget.lastName}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                            if (widget.isDirector)
                              Container(
                                margin: EdgeInsets.only(left: 8.0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
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
                        SizedBox(height: 2),
                        Text(
                          widget.email,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.0,),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _sendMessageToMember(widget.phone);
                        },
                        child: Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: FaIcon(
                              FontAwesomeIcons.whatsapp,
                              color: Colors.green,
                              size: 27.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 3.0,),
                      GestureDetector(
                        onTap: () => _showUserDetails(context),
                        child: Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.info_outline_rounded,
                              color: Colors.blue,
                              size: 27.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  void _showUserDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          widthFactor: 0.7,
          child: Container(
            padding: EdgeInsets.only(bottom: 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 115.0, bottom: 25.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${widget.firstName} ${widget.lastName}',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        widget.email,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16.0),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Phone: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 16.0),
                            ),
                            TextSpan(
                              text: widget.phone == 'string'
                                  ? 'No specified'
                                  : widget.phone,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () => (),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              widget.isDirector ? Colors.red : Colors.green,
                        ),
                        child: Text(
                          widget.isDirector ? 'Director' : 'Team Member',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -80,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: CustomColors.white,
                        width: 8.0,
                      ),
                    ),
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/profile-placeholder.jpg',
                        image: widget.imageUrl,
                        fit: BoxFit.cover,
                        width: 160,
                        height: 160,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/profile-placeholder.jpg',
                            fit: BoxFit.cover,
                            width: 160,
                            height: 160,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
