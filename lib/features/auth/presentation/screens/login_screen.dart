import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/register/dialog/terms_and_conditions_dialog.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/custom_dialog_error.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/login/checkbox_remember.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/login/email_field.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/login/login_banner.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/login/password_field.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/text_divider.dart';
import 'package:aidmanager_mobile/shared/helpers/show_customize_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String name = "login_screen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // el mounted es para verificar que el estado del widget este
  // monstado en el arbol ya que se va a interacturar con el contexto
  Future<void> onSubmitLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    // acceso al provider para llamar a la funcion
    final authProvider = context.read<AuthProvider>();

    try {
      await authProvider.submitLoginUser(email.trim(), password.trim());

      if (!mounted) return;

      context.go('/home');
    } catch (e) {
      if (!mounted) return;
      // mostrar un dialog perzonalizado para cada exception
      final dialog = getErrorDialog(context, e as Exception);
      showErrorDialog(context, dialog);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double containerHeight = MediaQuery.of(context).size.height * 0.25;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final Image logo = Image.asset(
      'assets/images/aidmanager_logo.png',
      fit: BoxFit.contain,
    );

    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: CustomColors.lightGrey,
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
                        EmailField(
                          emailController: _emailController,
                        ),
                        const SizedBox(height: 25),
                        PasswordField(
                            passwordController:
                                _passwordController),
                        const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RememberCheckbox(),
                            Text(
                              "Forgot password?",
                              style: TextStyle(
                                  fontSize: 14.5,
                                  fontStyle: FontStyle.normal,
                                  color: CustomColors.darkGreen),
                            )
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
                        const SizedBox(height: 20),
                        Expanded(
                          child: Container(color: Colors.transparent),
                        ),
                        const _NotAccountText(),
                        const SizedBox(height: 15)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return authProvider.isLoading
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          strokeWidth: 8,
                          color: CustomColors.darkGreen,
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink();
          },
        ),
      ],
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
