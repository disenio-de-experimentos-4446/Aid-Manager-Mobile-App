import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/domain/entities/login_response.dart';
import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/custom_dialog_error.dart';
import 'package:aidmanager_mobile/features/auth/presentation/widgets/register/dialog/organization_created_dialog.dart';
import 'package:aidmanager_mobile/shared/helpers/show_customize_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class OrganizationScreen extends StatefulWidget {
  static const name = 'organization_screen';
  final DirectorData directorInfo;

  const OrganizationScreen({super.key, required this.directorInfo});

  @override
  State<OrganizationScreen> createState() => _OrganizationScreenState();
}

class _OrganizationScreenState extends State<OrganizationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _organizationNameController =
      TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _companyEmail = TextEditingController();

  void onSubmitOrganization() async {
    final organizationName = _organizationNameController.text;
    final organizationCountry = _countryController.text;
    final organizationEmail = _companyEmail.text;

    final authProvider = context.read<AuthProvider>();

    try {
      await authProvider.submitRegisterUser(
        widget.directorInfo.firstName,
        widget.directorInfo.lastName,
        widget.directorInfo.email,
        widget.directorInfo.password,
        0, // siempre es un role "Manager" -> 0
        "", // se manda vacio para que se genere el codigo desde el servidor(logica rara :v)
        companyName: organizationName,
        companyEmail: organizationEmail,
        companyCountry: organizationCountry,
      );

      if (!mounted) return;
      showCustomizeDialog(context, const OrganizationCreatedDialog());
    } catch (e) {
      if (!mounted) return;
      final dialog = getErrorDialog(context, e as Exception);
      showErrorDialog(context, dialog);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColors.darkGreen,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 210,
                    child: Center(
                      child: SizedBox(
                        width: deviceWidth * 0.85,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Transform.translate(
                                offset: const Offset(0, 5),
                                child: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28.0,
                                        height: 1.5,
                                        letterSpacing: 0.85),
                                    children: <TextSpan>[
                                      TextSpan(text: 'Create new Team\nin '),
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
                            ),
                            Image.asset(
                              'assets/images/create-team.png',
                              width: 160.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: CustomColors.lightGrey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: deviceWidth * 0.85,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Organizing your customers helps you create quicker quotes and keep track",
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w500,
                                      height: 1.65,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  TextField(
                                    controller: _organizationNameController,
                                    keyboardType: TextInputType.name,
                                    style: const TextStyle(fontSize: 18.0),
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
                                      hintText: 'Organization Name',
                                      hintStyle:
                                          const TextStyle(fontSize: 18.0),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 18.0),
                                      suffixIcon: const Padding(
                                        padding: EdgeInsets.only(right: 18.0),
                                        child: Icon(Icons.business, size: 28.0),
                                      ), // Icono al final
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  TextField(
                                    controller: _countryController,
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(fontSize: 18.0),
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
                                      hintText: 'Country/region',
                                      hintStyle:
                                          const TextStyle(fontSize: 18.0),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 18.0),
                                      suffixIcon: const Padding(
                                        padding: EdgeInsets.only(right: 18.0),
                                        child: Icon(Icons.public, size: 28),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  TextField(
                                    controller: _companyEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(fontSize: 18.0),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 18.0),
                                      suffixIcon: const Padding(
                                        padding: EdgeInsets.only(right: 18.0),
                                        child:
                                            Icon(Icons.email_rounded, size: 28),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  ElevatedButton(
                                    onPressed: () {
                                      onSubmitOrganization();
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
                                      'Create organization',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.8),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      //TODO: Mostrar Dialogo de cancelacion
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 255, 60, 46), // Color de fondo
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
                                      'Cancel registration',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.8),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Center(
                                    child: _HaveAccountText(),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: 10.0,
                left: 0.0,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context.go('/register');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
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
            text: "Are you a team member? ",
          ),
          TextSpan(
            text: 'Registrate',
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
