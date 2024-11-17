import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/social/presentation/providers/social_provider.dart';
import 'package:aidmanager_mobile/features/social/presentation/widgets/member_deleted_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class MembersDeletedScreen extends StatefulWidget {
  static const String name = "members_deleted_screen";

  const MembersDeletedScreen({
    super.key,
  });

  @override
  State<MembersDeletedScreen> createState() => _MembersDeletedScreenState();
}

class _MembersDeletedScreenState extends State<MembersDeletedScreen> {
  @override
  void initState() {
    super.initState();
    _loadProjectsByCurrentUser();
  }

  Future<void> _loadProjectsByCurrentUser() async {
    final socialProvider = context.read<SocialProvider>();

    await socialProvider.loadDeletedMembersFromCompany();
  }

  @override
  Widget build(BuildContext context) {
    final socialProvider = Provider.of<SocialProvider>(context, listen: false);
    final teamMembers = socialProvider.users
        .where((user) => user.role == "1")
        .toList();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: CustomColors.lightGrey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: CustomColors.darkGreen,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 32.0,
            ),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                context.go('/home');
              }
            },
          ),
          title: Text(
            'Past Members',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
            ),
          ),
          toolbarHeight: 70.0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.filter_list,
                color: Colors.white,
                size: 32.0,
              ),
              onPressed: () {
                // Acción al presionar el botón de filtro
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(22, 72, 255, 21),
              border: Border(
                bottom: BorderSide(
                  color: const Color.fromARGB(255, 172, 169, 169),
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 25.0,
                left: 20.0,
                right: 20.0,
                bottom: 25.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: '',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Nicolas',
                            style: TextStyle(
                              color: CustomColors.darkGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ', see the past members in the company!',
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                    child: teamMembers.isEmpty
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
                                    color: const Color.fromARGB(255, 143, 118, 118),
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: teamMembers.length,
                            itemBuilder: (context, index) {
                              final member = teamMembers[index];
                              final nameParts = member.name.split(' ');
                              final firstName =
                                  nameParts.isNotEmpty ? nameParts[0] : '';
                              final lastName = nameParts.length > 1
                                  ? nameParts.sublist(1).join(' ')
                                  : '';

                              return MemberDeletedCard(
                                userId: member.id!,
                                firstName: firstName,
                                lastName: lastName,
                                imageUrl: member.profileImg ?? '',
                                age: member.age!,
                                email: member.email,
                                phone: member.phone ?? '',
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
