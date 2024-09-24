import 'package:flutter/material.dart';

class OrganizationProfileScreen extends StatelessWidget {
  static const String name = "organization_profile_screen";

  const OrganizationProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),


            const Text(
              "Clean Carpayo Beach",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),


            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hope Haven",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.teal),
                    onPressed: () {

                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),


            const ProfileSectionTitle(title: "Description"),
            const Text(
              "Lorem ipsum dolor sit amet consectetur. Risus hac tellus lacus ac ac nisi at sit diam...",
              style: TextStyle(fontSize: 16.0),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Text("200/250", style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Check out how the project is doing...",
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Acción para ver métricas
                    },
                    icon: const Icon(Icons.bar_chart, color: Colors.white),
                    label: const Text("Metrics"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),


            const ProfileSectionTitle(title: "Add Any Socials"),
            ProfileDetailRow(
              icon: Icons.web,
              label: "www.HopeHeaven.com",
              onPressed: () {},
            ),
            ProfileDetailRow(
              icon: Icons.alternate_email,
              label: "@SocialMediaThing123",
              onPressed: () {},
            ),
            ProfileDetailRow(
              icon: Icons.alternate_email,
              label: "@SocialMediaThing",
              onPressed: () {},
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
          color: Colors.black87,
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
