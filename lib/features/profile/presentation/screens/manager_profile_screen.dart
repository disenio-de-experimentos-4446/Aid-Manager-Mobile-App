import 'package:flutter/material.dart';

class ManagerProfileScreen extends StatelessWidget {
  static const String name = "manager_profile_screen";

  const ManagerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Jesse Rosales',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const Icon(
              Icons.edit,
              color: Colors.teal,
              size: 20,
            ),
            const SizedBox(height: 20),


            const ProfileSectionTitle(title: "Contact Info"),
            ProfileDetailRow(
              icon: Icons.phone,
              label: '+51 928 674 XXX',
              onPressed: () {},
            ),
            ProfileDetailRow(
              icon: Icons.email,
              label: 'Example@example.com',
              onPressed: () {},
            ),

            const SizedBox(height: 20),

            // Security Section
            const ProfileSectionTitle(title: "Security"),
            ProfileDetailRow(
              icon: Icons.lock,
              label: '********',
              onPressed: () {},
            ),
            ProfileDetailRow(
              icon: Icons.key,
              label: 'Organization Key',
              onPressed: () {},
            ),
            const Text(
              'This key provides sign-in access to your team members in the organization.\nBe careful',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 5),
            ProfileDetailRow(
              icon: Icons.remove_red_eye_outlined,
              label: '********',
              onPressed: () {},
            ),

            const SizedBox(height: 20),

            // Recent Projects Section
            const ProfileSectionTitle(title: "Recent Projects"),
            const RecentProject(
              projectName: 'Clean Carpayo Beach',
              imagePath: 'assets/images/hotman-placeholder.jpg',
            ),
            const RecentProject(
              projectName: 'Garden Keeping',
              imagePath: 'assets/images/hotman-placeholder.jpg',
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileSectionTitle extends StatelessWidget {
  final String title;

  const ProfileSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const ProfileDetailRow({super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black54),
              const SizedBox(width: 10),
              Text(label, style: const TextStyle(fontSize: 16)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.teal),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

class RecentProject extends StatelessWidget {
  final String projectName;
  final String imagePath;

  const RecentProject({super.key,
    required this.projectName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              projectName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
