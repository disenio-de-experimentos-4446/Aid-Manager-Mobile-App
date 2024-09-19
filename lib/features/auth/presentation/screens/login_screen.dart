import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RememberCheckbox extends StatefulWidget {
  const RememberCheckbox({super.key});

  @override
  RemeberCheckboxState createState() => RemeberCheckboxState();
}

class RemeberCheckboxState extends State<RememberCheckbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-10, 0),
      child: Row(
        children: [
          Checkbox(
            activeColor: Colors.green[700],
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value ?? false;
              });
            },
          ),
          const Text(
            'Remenber me',
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {

  static const String name = "login_screen";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double containerHeight = MediaQuery.of(context).size.height * 0.25;
    final double deviceWitdh = MediaQuery.of(context).size.width;
    final Image logo = Image.asset(
      'assets/images/aidmanager_logo.png',
      fit: BoxFit.contain,
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColors.lightGrey, // Usando el color lightGreen
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: containerHeight,
                  decoration: const BoxDecoration(
                    color: CustomColors.darkGreen,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(999),
                      bottomRight: Radius.circular(999),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: (deviceWitdh / 2) - 70,
                  child: Transform.translate(
                    offset: const Offset(0, 70),
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: CustomColors.white,
                        shape: BoxShape.circle,
                        border:
                            Border.all(width: 0.5, color: CustomColors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: logo,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 90),
            Expanded(
              child: SizedBox(
                width: deviceWitdh * 0.85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'AidManager',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.65,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      style: const TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: CustomColors.fieldGrey,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: CustomColors.grey,
                          ),
                        ),
                        hintText: 'Email Address',
                        hintStyle: const TextStyle(fontSize: 18.0),
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(
                              right:
                                  18.0), // Ajusta el padding según sea necesario
                          child: Icon(Icons.email_rounded, size: 28),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 18.0),
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      style: const TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: CustomColors.fieldGrey,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: const BorderSide(
                            color: CustomColors.grey,
                          ),
                        ),
                        hintText: 'Password',
                        hintStyle: const TextStyle(fontSize: 18.0),
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(
                              right:
                                  18.0), // Ajusta el padding según sea necesario
                          child: Icon(Icons.remove_red_eye_rounded, size: 28),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 18.0),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RememberCheckbox(),
                        Text("Forgot password?",
                            style: TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.normal,
                                color: CustomColors.darkGreen))
                      ],
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        context.push('/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            CustomColors.darkGreen, // Color de fondo
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        minimumSize: const Size(double.infinity, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.8),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'or continue with',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Acción a realizar cuando se presiona el botón de Facebook
                            },
                            icon:
                                const Icon(Icons.facebook, color: Colors.blue),
                            label: const Text(
                              'Facebook',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.blue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 16.0), // Espaciado entre los botones
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Acción a realizar cuando se presiona el botón de Google
                            },
                            icon: Image.asset(
                              'assets/images/google-icon.webp', // Ruta de la imagen del logo de Google
                              height:
                                  24.0, // Ajusta el tamaño según sea necesario
                            ),
                            label: const Text(
                              'Google',
                              style: TextStyle(color: Colors.red, fontSize: 18),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0.8,
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(
                            text: "Don't have an account? ",
                          ),
                          TextSpan(
                            text: 'Sign up',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors
                                  .teal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.push('/register');
                              },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
