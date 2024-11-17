import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';
import 'package:flutter/material.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/project/dialog/delete_project_favorite_dialog.dart';
import 'package:go_router/go_router.dart';

class ProjectUserCard extends StatelessWidget {
  final int projectId;
  final String name;
  final String description;
  final List<String> imagesUrl;
  final DateTime projectDate;
  final TimeOfDay projectTime;
  final String projectLocation;
  final List<dynamic> userList;
  final VoidCallback onPressedCard;
  final VoidCallback onDeleteFavorite;

  const ProjectUserCard({
    super.key,
    required this.name,
    required this.description,
    required this.imagesUrl,
    required this.userList,
    required this.onPressedCard,
    required this.onDeleteFavorite,
    required this.projectId,
    required this.projectDate,
    required this.projectTime,
    required this.projectLocation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressedCard,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Card(
          color: const Color.fromARGB(255, 241, 241, 241),
          elevation: 1.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    imagesUrl[0],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/placeholder-image.webp',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Positioned(
                    top: 15.0,
                    right: 15.0,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColors.lightGrey,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                              size: 32.0,
                            ),
                            onPressed: () {
                              final projectInfo = Project(
                                name: name,
                                description: description,
                                imageUrl: imagesUrl,
                                projectDate: projectDate,
                                projectTime: projectTime,
                                projectLocation: projectLocation
                              );
                              context.go('/projects/edit/$projectId',
                                  extra: projectInfo);
                            },
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColors.lightGrey,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 32.0,
                            ),
                            onPressed: () async {
                              final result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DeleteProjectFavoriteDialog(
                                    onConfirm: () {
                                      Navigator.of(context).pop(true);
                                    },
                                  );
                                },
                              );

                              if (result == true) {
                                onDeleteFavorite();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.65,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.group,
                              color: Colors.grey,
                              size: 28.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '${userList.length} miembros',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                              width: 1.0,
                            ),
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 3.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                color: Colors.yellow[700],
                                size: 30,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                '4.5',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.yellow[800],
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
