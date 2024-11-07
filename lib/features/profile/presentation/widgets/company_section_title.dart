import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/profile/presentation/providers/profile_provider.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/custom_dialog_error.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/is_empty_dialog.dart';

class CompanySectionTitle extends StatefulWidget {
  final String title;
  final String companyName;
  final String companyEmail;
  final String companyUbication;

  const CompanySectionTitle({
    super.key,
    required this.companyName,
    required this.companyEmail,
    required this.companyUbication,
    required this.title,
  });

  @override
  State<CompanySectionTitle> createState() => _CompanySectionTitleState();
}

class _CompanySectionTitleState extends State<CompanySectionTitle> {
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _companyEmailController = TextEditingController();
  TextEditingController _companyUbicationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _companyNameController = TextEditingController(text: widget.companyName);
    _companyEmailController = TextEditingController(text: widget.companyEmail);
    _companyUbicationController =
        TextEditingController(text: widget.companyUbication);
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _companyEmailController.dispose();
    _companyUbicationController.dispose();
    super.dispose();
  }

  Future<void> onSubmitUpdateCompanyInformation() async {
    final companyName = _companyNameController.text.trim();
    final companyEmail = _companyEmailController.text.trim();
    final companyUbication = _companyUbicationController.text.trim();

    if (companyName.isEmpty ||
        companyEmail.isEmpty ||
        companyUbication.isEmpty) {
      showErrorDialog(
        context,
        const IsEmptyDialog(),
      );
      return;
    }

    // cerramos el modal luego de hacer el submit
    Navigator.pop(context);

    final profileProvider = context.read<ProfileProvider>();

    try {
      await profileProvider.updateCompanyInformation(
          companyName, companyEmail, companyUbication);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Company information updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update company information: $e')),
      );
    }
  }

  void _showEditCompanyModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Company Information',
                      style: TextStyle(
                        color: CustomColors.darkGreen,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        onSubmitUpdateCompanyInformation();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _companyNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Company Name',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _companyEmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Company Email',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _companyUbicationController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Company Ubication',
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
          ),
        ),
        TextButton.icon(
          onPressed: () {
            _showEditCompanyModal(context);
          },
          label: Text(
            'Edit Info',
            style: TextStyle(color: CustomColors.darkGreen, fontSize: 17.0),
          ),
          icon: Icon(Icons.edit, color: CustomColors.darkGreen),
        ),
      ],
    );
  }
}
