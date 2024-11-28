import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';

class TermsConditionsScreen extends StatefulWidget {
  static const String name = "terms_conditions_screen";

  const TermsConditionsScreen({super.key});

  @override
  _TermsConditionsScreenState createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  bool acceptTerms = false;
  bool acceptPrivacyPolicy = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black.withOpacity(0.8),
    ));

    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: CustomColors.darkGreen,
              resizeToAvoidBottomInset: false,
              body: LayoutBuilder(
                builder: (context, constraints) {
                  final availableHeight = constraints.maxHeight;
                  final containerHeight = availableHeight * 0.25 + 10;
                  final initialChildSize =
                      (availableHeight - containerHeight) / availableHeight;

                  return Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: containerHeight,
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30, top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Transform.translate(
                                  offset: const Offset(0, 5),
                                  child: RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          height: 1.65,
                                          letterSpacing: 0.85),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Terms and Conditions\nof '),
                                        TextSpan(
                                          text: 'AidManager',
                                          style: TextStyle(
                                            color: Colors.lightGreen,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/terms.png',
                                  width: 100.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 15.0,
                        left: 5.0,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            context.pop();
                          },
                        ),
                      ),
                      DraggableScrollableSheet(
                        initialChildSize: initialChildSize,
                        maxChildSize: 1.0,
                        minChildSize: initialChildSize,
                        builder: (context, scrollController) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: CustomColors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 5,
                                          width: 45,
                                          color: CustomColors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "1. Introduction",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Welcome to AidManager. These terms and conditions outline the rules and regulations for the use of AidManager's application.",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  const Text(
                                    "2. User Responsibilities",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "By accessing this application, we assume you accept these terms and conditions. Do not continue to use AidManager if you do not agree to all of the terms and conditions stated on this page.",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  const Text(
                                    "3. Privacy Policy",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "We are committed to protecting your privacy. Authorized employees within the company on a need-to-know basis only use any information collected from individual customers.",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  const Text(
                                    "4. Changes to Terms",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "AidManager reserves the right to revise these terms and conditions at any time. By using this application, you are expected to review these terms on a regular basis.",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  const Text(
                                    "5. Contact Us",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "If you have any questions about these Terms, please contact us at support@aidmanager.com.",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  Transform.translate(
                                    offset: Offset(-10, 0),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: acceptTerms,
                                          activeColor: CustomColors.darkGreen,
                                          onChanged: (value) {
                                            setState(() {
                                              acceptTerms = value ?? false;
                                            });
                                          },
                                        ),
                                        Flexible(
                                          child: const Text(
                                            'I accept the Terms and Conditions',
                                            style: TextStyle(fontSize: 16.0),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Transform.translate(
                                    offset: Offset(-10, 0),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: acceptPrivacyPolicy,
                                          activeColor: CustomColors.darkGreen,
                                          onChanged: (value) {
                                            setState(() {
                                              acceptPrivacyPolicy =
                                                  value ?? false;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'I accept the Privacy Policy',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed:
                                        acceptTerms && acceptPrivacyPolicy
                                            ? () {
                                                // Acción al aceptar términos y condiciones
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Terms and Conditions Accepted'),
                                                  ),
                                                );

                                                context.go('/home');
                                              }
                                            : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: CustomColors.darkGreen,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      minimumSize:
                                          const Size(double.infinity, 0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                                    child: const Text(
                                      'Accept',
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.8,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
