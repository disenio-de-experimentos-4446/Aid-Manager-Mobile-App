import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/invalid_email_dialog.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/is_empty_dialog.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/login/checkbox_remember.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/login/email_field.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/login/login_banner.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/login/password_field.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/text_divider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  static const String name = "login_screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void onSubmitLogin() {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const IsEmptyDialog();
          });

      return;
    }

    if (!_isValidEmail(email)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const InvalidEmailDialog();
          });

      return;
    }

    // de ahi se agrega era pa testear esta wea
    /* if(email == "macum@sexo.com" && password =="necum") {
      context.go('/home');      
      return;
    } */
    
    context.go('/home');
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final double containerHeight = MediaQuery.of(context).size.height * 0.25;
    final double deviceWidth = MediaQuery.of(context).size.width;
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
            LoginBanner(
                containerHeight: containerHeight,
                deviceWidth: deviceWidth,
                logoImage: logo),
            const SizedBox(height: 90),
            Expanded(
              child: SizedBox(
                width: deviceWidth * 0.85,
                child: Form(
                  key: _formKey,
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
                      EmailField(emailController: _emailController,), // widget for email field
                      const SizedBox(height: 25),
                      PasswordField(passwordController: _passwordController), // widget for password field
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
                          onSubmitLogin();
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
                          'Sign In',
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.8),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const TextDivider(text: 'or continue with'),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // hacer algo aqui (nekomensaje)
                              },
                              icon: const Icon(Icons.facebook,
                                  color: Colors.blue),
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
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18),
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
                        child: Container(color: Colors.transparent),
                      ),
                      const _NotAccountText(),
                      const SizedBox(height: 15)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotAccountText extends StatelessWidget {
  const _NotAccountText();

  @override
  Widget build(BuildContext context) {
    return RichText(
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
              color: CustomColors.teal,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.push('/register');
              },
          ),
        ],
      ),
    );
  }
}
