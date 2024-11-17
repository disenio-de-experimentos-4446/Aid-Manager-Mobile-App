import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MenuItem {
  final IconData icon;
  final String title;
  final String link;

  MenuItem({required this.icon, required this.title, required this.link});
}

final List<MenuItem> appMenuItems = [
  MenuItem(icon: Icons.article, title: 'Your posts', link: '/home'),
  MenuItem(icon: Icons.work, title: 'Your projects', link: '/projects'),
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
                      const EdgeInsets.only(bottom: 20.0, top: 40.0, left: 20),
                  decoration: const BoxDecoration(
                    color: CustomColors.darkGreen,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Team:  ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: user?.companyName ?? 'No Company Name',
                              style: TextStyle(
                                color: Colors.white,
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
                Material(
                  color: CustomColors.lightGrey,
                  child: InkWell(
                    onTap: () {
                      context.go('/profile');
                      context.pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, top: 25.0, bottom: 25.0, right: 15.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                              user?.profileImg?.isNotEmpty == true
                                  ? user!.profileImg!
                                  : 'https://st3.depositphotos.com/4111759/13425/v/600/depositphotos_134255710-stock-illustration-avatar-vector-male-profile-gray.jpg',
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user?.name ?? 'No Name',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  user?.email ?? 'No email',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 1,
              color: Colors.black26,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 26, 16, 10),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Primary Activities',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.darkGreen,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.format_list_bulleted_rounded,
                    color: CustomColors.darkGreen,
                  ),
                ],
              ),
            ),
            (user?.role ?? 'No Role') == 'Manager'
                ? Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.push('/projects/user/${user!.id}');
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(left: 20.0),
                        leading: FaIcon(
                          FontAwesomeIcons.anglesRight,
                          size: 20.0,
                        ),
                        title: Text('Your Projects'),
                      ),
                    ),
                  )
                : Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.push('/projects/user/${user!.id}/tasks');
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(left: 20.0),
                        leading: FaIcon(
                          FontAwesomeIcons.anglesRight,
                          size: 20.0,
                        ),
                        title: Text('Your tasks'),
                      ),
                    ),
                  ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.push('/posts/user/${user!.id}');
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 20.0),
                  leading: FaIcon(
                    FontAwesomeIcons.anglesRight,
                    size: 20.0,
                  ),
                  title: Text('Your posts'),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 16, 28, 10),
              child: Divider(),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 10, 16, 10),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'My favorites',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.darkGreen,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.favorite_outline_rounded,
                    color: CustomColors.darkGreen,
                    size: 24.0,
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.push('/projects/favorites/user/${user!.id}');
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 20.0),
                  leading: FaIcon(
                    FontAwesomeIcons.anglesRight,
                    size: 20.0,
                  ),
                  title: Text('Projects'),
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.push('/posts/saved/user/${user!.id}');
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 20.0),
                  leading: FaIcon(
                    FontAwesomeIcons.anglesRight,
                    size: 20.0,
                  ),
                  title: Text('Posts'),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 16, 28, 10),
              child: Divider(),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 10, 16, 10),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'More options',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.darkGreen,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.add_box_outlined,
                    color: CustomColors.darkGreen,
                    size: 24.0,
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.go('/social/members-deleted');
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 20.0),
                  leading: FaIcon(
                    FontAwesomeIcons.anglesRight,
                    size: 20.0,
                  ),
                  title: Text('Past members'),
                ),
              ),
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20.0),
              leading: const Icon(
                Icons.article,
                size: 24.0,
              ),
              title: const Text('Terms & Conditions'),
              onTap: () {
                // Acción al hacer clic en Settings
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 20.0, bottom: 8),
              leading: const Icon(
                Icons.logout,
                size: 24.0,
              ),
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
