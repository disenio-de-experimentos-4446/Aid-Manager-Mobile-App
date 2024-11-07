import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectCardList extends StatelessWidget {
  final List<Project> projects;

  const ProjectCardList({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
        return Column(
          children: [
            PrincipalProjectCard(
              name: project.name,
              description: project.description,
              imagesUrl: project.imageUrl,
              userList: project.userList!,
              onPressedCard: () {
                context.go('/projects/${project.id}');
              },
            ),
            if (index < projects.length - 1) SizedBox(height: 20.0),
          ],
        );
      },
    );
  }
}

class PrincipalProjectCard extends StatelessWidget {
  final String name;
  final String description;
  final List<String> imagesUrl;
  final List<dynamic> userList;
  final VoidCallback onPressedCard;

  const PrincipalProjectCard({
    super.key,
    required this.onPressedCard,
    required this.name,
    required this.description,
    required this.imagesUrl,
    required this.userList,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressedCard,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Card(
          color: const Color.fromARGB(255, 247, 247, 247),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.black87,
                          size: 30.0,
                        ),
                        onPressed: () {
                          // Acción del botón
                        },
                      ),
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
                              width: 1.0
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
