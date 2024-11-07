import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MenuItem {
  final IconData icon;
  final String title;
  final String link;

  MenuItem({required this.icon, required this.title, required this.link});
}

final List<MenuItem> appMenuItems = [
  MenuItem(icon: Icons.home, title: 'Home', link: '/home'),
  MenuItem(icon: Icons.work, title: 'Projects', link: '/projects'),
  MenuItem(icon: Icons.article, title: 'Posts', link: '/posts'),
  MenuItem(icon: Icons.calendar_today, title: 'Calendar', link: '/calendar'),
  MenuItem(icon: Icons.people, title: 'Social', link: '/social'),
];

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    print("USERINSIDEENU ${user?.profileImg}");

    return Drawer(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        color: CustomColors.lightGrey,
        child: Column(
          children: <Widget>[
            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.only(bottom: 20.0, top: 35.0, left: 20),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 202, 218, 198),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Team: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: user?.companyName ?? 'No Company Name',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          user?.profileImg?.isNotEmpty == true
                              ? user!.profileImg!
                              : 'https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg',
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user?.name ?? 'No Name',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            user?.email ?? 'No email',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10),
            ...appMenuItems.sublist(0, 3).map(
                  (item) => ListTile(
                    contentPadding: const EdgeInsets.only(left: 20.0),
                    leading: Icon(item.icon),
                    title: Text(item.title),
                  ),
                ),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 16, 28, 10),
              child: Divider(),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 10, 16, 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'More options',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.mediumGreen),
                ),
              ),
            ),
            ...appMenuItems.sublist(3).map(
                  (item) => ListTile(
                    contentPadding: const EdgeInsets.only(left: 20.0),
                    leading: Icon(item.icon),
                    title: Text(item.title),
                  ),
                ),
            const Spacer(),
            const Divider(),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20.0),
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Acción al hacer clic en Settings
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20.0, bottom: 8),
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                Navigator.of(context).pop();
                  
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                await authProvider.signOut();
                if (!mounted) return;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();
                  context.go('/');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
