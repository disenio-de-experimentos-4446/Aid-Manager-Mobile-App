import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/social/presentation/providers/social_provider.dart';
import 'package:aidmanager_mobile/features/social/presentation/widgets/dialog/error_fetch_users_dialog.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aidmanager_mobile/features/social/presentation/widgets/contact_card.dart';

import '../../../../config/theme/app_theme.dart';

class SocialScreen extends StatelessWidget {
  static const String name = "social_screen";

  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const SocialContentState(),
        );
      },
    );
  }
}

class SocialContentState extends StatefulWidget {
  const SocialContentState({super.key});

  @override
  State<SocialContentState> createState() => _SocialContentStateState();
}

class _SocialContentStateState extends State<SocialContentState> {
  final TextEditingController searchController = TextEditingController();
  List<User> filteredUsers = [];
  bool isAscending = true;
  bool showLabel = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
    Future.delayed(Duration(seconds: 6), () {
      if(!mounted) return;
      setState(() {
        showLabel = false;
      });
    });
    searchController.addListener(_filterUsers);
  }

  Future<void> _loadUsers() async {
    try {
      final socialProvider = Provider.of<SocialProvider>(context, listen: false);
      await socialProvider.getMembersByCompany();

      // importante antes de act el estado verificar si ya se encuentra montado
      if (!mounted) return;

      setState(() {
        filteredUsers = socialProvider.users;
      });
    } catch (e) {
      if (mounted) {
        ErrorFetchUsersDialog.show(context);
      }
    }
  }

  void _filterUsers() {
    final query = searchController.text.toLowerCase();
    final socialProvider = Provider.of<SocialProvider>(context, listen: false);
    setState(() {
      filteredUsers = socialProvider.users.where((user) {
        return user.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _sortUsers() {
    setState(() {
      isAscending = !isAscending;
      filteredUsers.sort((a, b) {
        return isAscending
            ? a.name.compareTo(b.name)
            : b.name.compareTo(a.name);
      });
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterUsers);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socialProvider = Provider.of<SocialProvider>(context, listen: false);
    final isDirector = socialProvider.authProvider.user?.role == 'Manager';

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: CustomColors.lightGrey,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: CustomColors.fieldGrey,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 0.5,
                                      blurRadius: 1,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Search a contact',
                                    prefixIcon: Icon(Icons.search),
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 12.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.0),
                            TextButton(
                              onPressed: _sortUsers,
                              style: TextButton.styleFrom(
                                backgroundColor: CustomColors.darkGreen,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0,
                                  vertical: 8.0,
                                ),
                              ),
                              child: Text(
                                isAscending ? 'A - Z' : 'Z - A',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                socialProvider.isLoading
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Expanded(
                        child: socialProvider.users.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.group_off,
                                        size: 48, color: Colors.grey),
                                    SizedBox(height: 15),
                                    Text(
                                      'No users in the company',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: filteredUsers.length,
                                itemBuilder: (context, index) {
                                  final member = filteredUsers[index];
                                  final nameParts = member.name.split(' ');
                                  final firstName =
                                      nameParts.isNotEmpty ? nameParts[0] : '';
                                  final lastName = nameParts.length > 1
                                      ? nameParts.sublist(1).join(' ')
                                      : '';

                                  return ContactCard(
                                    userId: member.id!,
                                    firstName: firstName,
                                    lastName: lastName,
                                    imageUrl: member.profileImg ?? '',
                                    age: member.age!,
                                    email: member.email,
                                    phone: member.phone ?? '',
                                    isDirector: member.role == 'Manager',
                                    onDelete: isDirector
                                        ? () async {
                                            await socialProvider
                                                .kickMemberFromCompany(
                                                    member.id!);
                                            setState(() {});
                                          }
                                        : null,
                                  );
                                },
                              ),
                      ),
              ],
            ),
            if (isDirector && showLabel)
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: FadeInUp(
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.swipe, color: Colors.white),
                          SizedBox(width: 8.0),
                          Text(
                            'Swipe to delete a member',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
