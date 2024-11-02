import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';
import 'package:flutter/material.dart';

class ProjectsCarousel extends StatelessWidget {
  final List<Project> projects;

  const ProjectsCarousel({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: CarouselView(
        itemExtent: MediaQuery.sizeOf(context).width - 96,
        padding: const EdgeInsets.only(right: 10),
        itemSnapping: true,
        elevation: 4.0,
        children: List.generate(projects.length, (int index) {
          final project = projects[index];
          return ProjectCard(
            projectName: project.name,
            membersCount: project.userList?.length ?? 0,
            imageUrl: project.imageUrl[0],
          );
        }),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String projectName;
  final int membersCount;
  final String imageUrl;

  const ProjectCard({
    super.key,
    required this.projectName,
    required this.membersCount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Stack(
        children: [
          Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/placeholder-image.webp',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  );
                },
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.60),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      projectName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.05,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 24.0,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '$membersCount members',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 214, 214, 214),
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}