import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/custom_dialog_error.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/is_empty_dialog.dart';
import 'package:aidmanager_mobile/features/profile/presentation/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ProfileSectionTitle extends StatefulWidget {
  final String title;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String age;

  const ProfileSectionTitle({
    super.key,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.age,
  });

  @override
  State<ProfileSectionTitle> createState() => _ProfileSectionTitleState();
}

class _ProfileSectionTitleState extends State<ProfileSectionTitle> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _phoneController = TextEditingController(text: widget.phone);
    _emailController = TextEditingController(text: widget.email);
    _ageController = TextEditingController(text: widget.age);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> onSubmitUpdateInformation() async {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();
    final age = int.tryParse(_ageController.text.trim());

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        age == null) {
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
      await profileProvider.updatePersonalInformation(
          firstName, lastName, phone, email, age);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Information updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update information: $e')),
      );
    }
  }

  void _showEditInfoModal(BuildContext context) {
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
                      'Personal Information',
                      style: TextStyle(
                        color: CustomColors.darkGreen,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        onSubmitUpdateInformation();
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
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _firstNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _lastNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Age',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
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
            _showEditInfoModal(context);
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
