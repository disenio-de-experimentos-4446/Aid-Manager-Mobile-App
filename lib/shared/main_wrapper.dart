import 'package:aidmanager_mobile/shared/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class MainWrapper extends StatefulWidget {
  final Widget? child;

  const MainWrapper({super.key, this.child});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  void _onIndexSelected(int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/projects');
        break;
      case 2:
        context.go('/posts');
        break;
      case 3:
        context.go('/calendar');
        break;
      case 4:
        context.go('/social');
        break;
      case 5:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final routeIndexMap = {
      '/home': 0,
      '/projects': 1,
      '/posts': 2,
      '/calendar': 3,
      '/social': 4,
      '/profile': 5,
    };

    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.last.matchedLocation;

    int currentIndex = routeIndexMap.entries
        .firstWhere((entry) => currentRoute.startsWith(entry.key),
            orElse: () => MapEntry('', 0))
        .value;

    // lista de rutas donde no se debe mostrar el AppBar
    final noAppBarRoutes = [
      '/projects/',
      '/posts/',
      '/user/',
      '/saved/posts/',
      '/favorites/projects/',
      '/social/members-deleted'
    ];

    // determinar si se debe mostrar el AppBar
    bool showTopbar = !noAppBarRoutes.any((route) => currentRoute.startsWith(route));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: scaffoldKey,
      appBar: showTopbar
          ? AppBar(
              toolbarHeight: 70,
              backgroundColor: CustomColors.darkGreen,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) {
                      return IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 32.0,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
                  const Text(
                    'AidManager',
                    style: TextStyle(
                        fontSize: 24.0, color: CustomColors.lightGrey),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.account_circle_sharp,
                      size: 32,
                      color: CustomColors.lightGrey,
                    ),
                    onPressed: () => _onIndexSelected(5),
                  ),
                ],
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
            )
          : null,
      body: widget.child,
      drawer: SideMenu(
        scaffoldKey: scaffoldKey,
      ),
      bottomNavigationBar: _AidNavigationBar(
        index: currentIndex,
        onIndexSelected: _onIndexSelected,
      ),
    );
  }
}

class _AidNavigationBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onIndexSelected;

  const _AidNavigationBar({required this.index, required this.onIndexSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.0,
      decoration: BoxDecoration(
        color: CustomColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNavItem(Icons.home_rounded, 'Home', 0),
            _buildNavItem(Icons.work_rounded, 'Projects', 1),
            _buildNavItem(Icons.post_add_rounded, 'Reports', 2),
            _buildNavItem(Icons.calendar_month_rounded, 'Calendar', 3),
            _buildNavItem(Icons.group_rounded, 'Social', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int itemIndex) {
    final isSelected = index == itemIndex;

    return GestureDetector(
      onTap: () => onIndexSelected(itemIndex),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? CustomColors.darkGreen : CustomColors.grey,
              size: 30.0,
            ),
            const SizedBox(height: 5.0),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? CustomColors.darkGreen : CustomColors.grey,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
