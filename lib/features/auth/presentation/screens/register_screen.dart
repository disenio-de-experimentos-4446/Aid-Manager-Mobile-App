import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/domain/entities/login_response.dart';
import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/register/dialog/terms_and_conditions_dialog.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/custom_dialog_error.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/invalid_email_dialog.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/is_empty_dialog.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/register/dialog/access_code_team_dialog.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/register/dialog/passwords_not_same_dialog.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/register/dialog/register_sucessfully_dialog.dart';
import 'package:aidmanager_mobile/features/auth/shared/helpers/regex_helper.dart';
import 'package:aidmanager_mobile/shared/helpers/show_customize_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String name = "register_screen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  // to manage the checkboxs owo
  bool isDirectorSelected = true;
  bool isTeamSelected = false;

  void onSubmitRegister() async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final passwordConfirm = _passwordConfirmController.text;

    // asigamos el rol basado en la selección del usuario (se manda como int)
    final role = isDirectorSelected
        ? 0
        : isTeamSelected
            ? 1
            : 0;

    // validaciones petes :p
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        passwordConfirm.isEmpty ||
        (!isDirectorSelected && !isTeamSelected)) {
      showCustomizeDialog(context, const IsEmptyDialog());
      return;
    }

    if (password != passwordConfirm) {
      showCustomizeDialog(context, const PasswordsNotSameDialog());
      return;
    }

    if (!RegexHelper.isValidEmail(email)) {
      showCustomizeDialog(context, const InvalidEmailDialog());
      return;
    }

    // acceso al provider para llamar a la función de registro
    final authProvider = context.read<AuthProvider>();

    try {
      if (role == 0) {
        // si el rol es director, navegamos a la pantalla de organizacion
        // mandamos el objeto que contiene la informacion de los campos completados hasta ahora
        final directorInfo = DirectorData(firstName, lastName, email, password);
        context.go('/organization', extra: directorInfo);
      } else if (role == 1) {
        if (!mounted) return;

        final response = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) => const TermsAndConditionsDialog(),
        );

        if (response != true) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'No se puede hacer el registro sin aceptar los términos y condiciones.'),
            ),
          );
          return;
        }

        if (!mounted) return;

        // si el rol es miembro del equipo, solicitar el codigo de acceso al equipo
        final teamRegisterCode = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return const AccessCodeTeamDialog();
          },
        );

        if (teamRegisterCode == null || teamRegisterCode.isEmpty) return;

        await authProvider.submitRegisterUser(
          firstName,
          lastName,
          email,
          password,
          role,
          teamRegisterCode,
        );

        if (!mounted) return;

        showCustomizeDialog(context, const RegisterSuccessfullyDialog());
      }
    } catch (e) {
      if (!mounted) return;

      final dialog = getErrorDialog(context, e as Exception);
      showErrorDialog(context, dialog);
    }
  }

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
                                          fontSize: 22.0,
                                          height: 1.5,
                                          letterSpacing: 0.85),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Create an account\nin '),
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
                                  'assets/images/register-person.png',
                                  width: 120.0,
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
                            context.go('/');
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
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Transform your idea with us",
                                          style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.0,
                                            height: 1.75,
                                            color: Colors.black,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextField(
                                                controller:
                                                    _firstNameController,
                                                keyboardType:
                                                    TextInputType.name,
                                                style: const TextStyle(
                                                    fontSize: 18.0),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor:
                                                      CustomColors.fieldGrey,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: CustomColors.grey,
                                                    ),
                                                  ),
                                                  hintText: 'First Name',
                                                  hintStyle: const TextStyle(
                                                      fontSize: 18.0),
                                                  suffixIcon: const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 18.0),
                                                    child: Icon(Icons.person,
                                                        size: 28),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 20.0,
                                                          horizontal: 18.0),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: TextField(
                                                controller: _lastNameController,
                                                keyboardType:
                                                    TextInputType.name,
                                                style: const TextStyle(
                                                    fontSize: 18.0),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor:
                                                      CustomColors.fieldGrey,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: CustomColors.grey,
                                                    ),
                                                  ),
                                                  hintText: 'Last Name',
                                                  hintStyle: const TextStyle(
                                                      fontSize: 18.0),
                                                  suffixIcon: const Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 18.0),
                                                    child: Icon(
                                                        Icons.person_add,
                                                        size: 28),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 20.0,
                                                          horizontal: 18.0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        TextField(
                                          controller: _emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style:
                                              const TextStyle(fontSize: 18.0),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: CustomColors.fieldGrey,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: CustomColors.grey,
                                              ),
                                            ),
                                            hintText: 'Institution Email',
                                            hintStyle:
                                                const TextStyle(fontSize: 18.0),
                                            suffixIcon: const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 18.0),
                                              child: Icon(Icons.email_rounded,
                                                  size: 28),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 20.0,
                                                    horizontal: 18.0),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        TextField(
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          controller: _passwordController,
                                          style:
                                              const TextStyle(fontSize: 18.0),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: CustomColors.fieldGrey,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: CustomColors.grey,
                                              ),
                                            ),
                                            hintText: 'Password',
                                            hintStyle:
                                                const TextStyle(fontSize: 18.0),
                                            suffixIcon: const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 18.0),
                                              child: Icon(Icons.remove_red_eye,
                                                  size: 28),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 20.0,
                                                    horizontal: 18.0),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        TextField(
                                          controller:
                                              _passwordConfirmController,
                                          style:
                                              const TextStyle(fontSize: 18.0),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: CustomColors.fieldGrey,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: CustomColors.grey,
                                              ),
                                            ),
                                            hintText: 'Confirm Password',
                                            hintStyle:
                                                const TextStyle(fontSize: 18.0),
                                            suffixIcon: const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 18.0),
                                              child: Icon(Icons.lock, size: 28),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 20.0,
                                                    horizontal: 18.0),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Transform.scale(
                                                  scale: 1.25,
                                                  child: Checkbox(
                                                    value: isDirectorSelected,
                                                    onChanged: (value) =>
                                                        setState(() {
                                                      isDirectorSelected =
                                                          value ?? false;
                                                      if (isDirectorSelected) {
                                                        isTeamSelected = false;
                                                      }
                                                    }),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    activeColor: Colors.green,
                                                  ),
                                                ),
                                                const Text(
                                                  'Director',
                                                  style:
                                                      TextStyle(fontSize: 18.0),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 35),
                                            Row(
                                              children: [
                                                Transform.scale(
                                                  scale: 1.25,
                                                  child: Checkbox(
                                                    value: isTeamSelected,
                                                    onChanged: (value) =>
                                                        setState(() {
                                                      isTeamSelected =
                                                          value ?? false;
                                                      if (isTeamSelected) {
                                                        isDirectorSelected =
                                                            false;
                                                      }
                                                    }),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    activeColor: Colors.green,
                                                  ),
                                                ),
                                                const Text(
                                                  'Team',
                                                  style:
                                                      TextStyle(fontSize: 18.0),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 25),
                                        ElevatedButton(
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            onSubmitRegister();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: CustomColors
                                                .darkGreen, // Color de fondo
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            minimumSize:
                                                const Size(double.infinity, 0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                          ),
                                          child: const Text(
                                            'Create account',
                                            style: TextStyle(
                                              fontSize: 22.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.8,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const Center(
                                          child: _HaveAccountText(),
                                        ),
                                      ],
                                    ),
                                  ),
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

class _HaveAccountText extends StatelessWidget {
  const _HaveAccountText();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.8,
          color: Colors.black,
        ),
        children: [
          const TextSpan(
            text: "Already have an account? ",
          ),
          TextSpan(
            text: 'Sign in',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: CustomColors.teal,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.push('/');
              },
          ),
        ],
      ),
    );
  }
}
