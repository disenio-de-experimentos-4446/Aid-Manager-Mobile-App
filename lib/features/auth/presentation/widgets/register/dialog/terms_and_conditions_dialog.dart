import 'package:flutter/material.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';

class TermsAndConditionsDialog extends StatefulWidget {
  const TermsAndConditionsDialog({super.key});

  @override
  State<TermsAndConditionsDialog> createState() =>
      _TermsAndConditionsDialogState();
}

class _TermsAndConditionsDialogState extends State<TermsAndConditionsDialog> {
  bool _agreeToTerms = false;
  bool _agreeToPrivacy = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: CustomColors.darkGreen,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Row(
              children: [
                Icon(
                  Icons.privacy_tip,
                  size: 54.0,
                  color: Colors.white,
                ),
                SizedBox(width: 12.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Terms of Service',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'November 18, 2024',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white70,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey, height: 1.5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    Text(
                      '1. Privacy Policy',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'We care about data privacy and security. By using the Services, you agree to be bound by our Privacy Policy posted on the Services, which is incorporated into these Legal Terms.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      '2. Legal Information',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'These Legal Terms constitute a legally binding agreement made between you, whether personally or on behalf of an entity, and AidRecruits, concerning your access to and use of the Services.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      '3. User Responsibilities',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'By using the Services, you represent and warrant that all registration information you submit will be true, accurate, current, and complete.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      '4. Prohibited Activities',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'You may not access or use the Services for any purpose other than that for which we make the Services available.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      '5. User Generated Contributions',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'The Services may invite you to chat, contribute to, or participate in blogs, message boards, online forums, and other functionality.',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  spreadRadius: 5,
                  blurRadius: 20,
                  offset: Offset(0, -5),
                ),
              ],
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(20.0)),
            ),
            child: Column(
              children: [
                Transform.translate(
                  offset: Offset(-10, 0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _agreeToTerms,
                        onChanged: (value) {
                          setState(() {
                            _agreeToTerms = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'I agree to the Terms and Conditions',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Transform.translate(
                  offset: Offset(-10, 0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _agreeToPrivacy,
                        onChanged: (value) {
                          setState(() {
                            _agreeToPrivacy = value!;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'I agree to the Privacy Policy',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('Decline'),
                    ),
                    ElevatedButton(
                      onPressed: _agreeToTerms && _agreeToPrivacy
                          ? () {
                              Navigator.of(context).pop(true);
                            }
                          : null,
                      child: Text('Accept'),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
