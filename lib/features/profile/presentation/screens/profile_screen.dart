import 'dart:io';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/profile/presentation/providers/profile_provider.dart';
import 'package:aidmanager_mobile/features/profile/presentation/widgets/company_section_title.dart';
import 'package:aidmanager_mobile/features/profile/presentation/widgets/dialog/access_code_visibility_dialog.dart';
import 'package:aidmanager_mobile/features/profile/presentation/widgets/dialog/successfully_profile_image_update_dialog.dart';
import 'package:aidmanager_mobile/features/profile/presentation/widgets/profile_section_title.dart';
import 'package:aidmanager_mobile/features/profile/shared/widgets/custom_error_profile_dialog.dart';
import 'package:aidmanager_mobile/shared/helpers/show_customize_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const String name = "profile_screen";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const ProfileContent(),
        );
      },
    );
  }
}

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  // ignore: unused_field
  File? _image;
  final picker = ImagePicker();

  bool _isCodeVisible = false;

  Future<void> getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadProfileImage();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No image selected.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  Future<void> getImageCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        uploadProfileImage();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No image selected.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  Future<void> uploadProfileImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No image selected.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final userProvider = context.read<ProfileProvider>();

    try {
      await userProvider.updateProfileImageFromCurrentUser(_image!);

      if (!mounted) return;

      showCustomizeDialog(context, SuccessfullyProfileImageUpdateDialog());
    } catch (e) {
      if (!mounted) return;
      // mostrar un dialog perzonalizado para cada exception
      final dialog = getProfileErrorDialog(context, e as Exception);
      showErrorDialog(context, dialog);
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                onTap: () {
                  getImageGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  getImageCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAccessCodeDialog() async {
    final authProvider = context.read<AuthProvider>();

    final password = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return const AccessCodeVisibilityDialog();
      },
    );

    if (!mounted || password == null || password.isEmpty) return;

    if (password != authProvider.user?.password) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Incorrect password. Please try again.')),
      );
      return;
    }

    setState(() {
      _isCodeVisible = true;
    });
  }

  void _shareTeamRegisterCode(String accessCode) async {
    final message = 'Here is the team register code: $accessCode';
    final whatsappUrl = 'https://wa.me/?text=${Uri.encodeComponent(message)}';

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch WhatsApp')),
      );
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Code copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final user = profileProvider.authProvider.user;

    final nameParts = user?.name.split(' ') ?? [];
    final firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    final lastName = nameParts.length > 1 ? nameParts[1] : '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
            child: Column(
              children: [
                GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        final double dialogSize =
                            MediaQuery.of(context).size.width * 0.8;
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.0),
                            child: Container(
                              width: dialogSize,
                              height: dialogSize,
                              padding: const EdgeInsets.all(0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14.0),
                                child: Image.network(
                                  user?.profileImg ??
                                      "https://static.vecteezy.com/system/resources/thumbnails/004/511/281/small/default-avatar-photo-placeholder-profile-picture-vector.jpg",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/profile-placeholder.jpg',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  onTap: () {
                    _showPicker(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2.0,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        user?.profileImg ??
                            "https://static.vecteezy.com/system/resources/thumbnails/004/511/281/small/default-avatar-photo-placeholder-profile-picture-vector.jpg",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/profile-placeholder.jpg',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user?.name ?? 'No Name',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.darkGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ProfileSectionTitle(
                  title: "Personal Information",
                  firstName: firstName,
                  lastName: lastName,
                  phone: user?.phone ?? 'No phone',
                  email: user?.email ?? 'No email',
                  age: user?.age.toString() ?? '0',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.black54),
                          const SizedBox(width: 12),
                          Text(
                            (user?.phone ?? "No phone") == "string"
                                ? "No phone"
                                : user?.phone ?? "No phone",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy_rounded,
                            color: CustomColors.darkGreen),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.black54),
                          const SizedBox(width: 12),
                          Text(
                            user?.email ?? 'No Name',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy_rounded,
                            color: CustomColors.darkGreen),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.cake, color: Colors.black54),
                          const SizedBox(width: 12),
                          Text(
                            (user?.age ?? "No Specified") == 0
                                ? "No Specified"
                                : user?.age.toString() ?? "0",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy_rounded,
                            color: CustomColors.darkGreen),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CompanySectionTitle(
                  title: 'Company Information',
                  companyName: user?.companyName ?? 'No Company Name',
                  companyEmail: user?.companyEmail ?? 'No Company Email',
                  companyUbication:
                      user?.companyCountry ?? 'No Company Ubication',
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.account_balance, color: Colors.black54),
                          const SizedBox(width: 12),
                          Text(
                            user?.companyName ?? 'No Company name',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy_rounded,
                            color: CustomColors.darkGreen),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.email, color: Colors.black54),
                          const SizedBox(width: 12),
                          Text(
                            user?.companyEmail ?? 'No Company email',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy_rounded,
                            color: CustomColors.darkGreen),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.black54),
                          const SizedBox(width: 12),
                          Text(
                            user?.companyCountry ?? 'No Company Country',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy_rounded,
                            color: CustomColors.darkGreen),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onDoubleTap: () {
                          if (_isCodeVisible) {
                            _copyToClipboard(
                                user?.teamRegisterCode ?? 'No Code available');
                          }
                        },
                        child: Row(
                          children: [
                            Icon(Icons.key, color: Colors.black54),
                            const SizedBox(width: 12),
                            Text(
                              _isCodeVisible
                                  ? user?.teamRegisterCode ??
                                      'No Code available'
                                  : '**********',
                              style: const TextStyle(
                                  fontSize: 16, letterSpacing: 0.70),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isCodeVisible
                              ? Icons.share
                              : Icons.lock_person_sharp,
                          color: CustomColors.darkGreen,
                        ),
                        onPressed: () {
                          if (_isCodeVisible) {
                            _shareTeamRegisterCode(user!.teamRegisterCode);
                          } else {
                            _showAccessCodeDialog();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Security',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lock, color: Colors.black54),
                          const SizedBox(width: 12),
                          Text(
                            user?.password ?? '********',
                            style: const TextStyle(
                                fontSize: 16, letterSpacing: 0.8),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_red_eye,
                            color: CustomColors.darkGreen),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (profileProvider.isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                    color: CustomColors.darkGreen,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
