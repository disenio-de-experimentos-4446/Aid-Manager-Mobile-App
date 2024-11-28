import 'package:aidmanager_mobile/features/projects/shared/helpers/get_random_priority.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskUserCard extends StatelessWidget {
  final int taskId;
  final int assignedTo;
  final String title;
  final String description;
  final DateTime dueDate;
  final String assignedImage;
  final VoidCallback onPressedCard;

  const TaskUserCard({
    super.key,
    required this.taskId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.assignedImage,
    required this.onPressedCard,
    required this.assignedTo,
  });

  @override
  Widget build(BuildContext context) {
    final priority = getPriorityFromDueDate(dueDate);
    final color = getPriorityColor(priority);

    return Column(
      children: [
        SizedBox(height: 25),
        GestureDetector(
          onTap: onPressedCard,
          child: Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.black54, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 8),
                        Transform.translate(
                          offset: Offset(0, 1),
                          child: Text(
                            DateFormat('yyyy-MM-dd').format(dueDate),
                            style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 8),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 41, 41,
                                41), // Color de fondo del contenedor
                            borderRadius:
                                BorderRadius.circular(20), // Bordes redondeados
                          ),
                          child: Text(
                            'Risk',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            priority,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.all(1.5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 219, 219, 219),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.green,
                            child: ClipOval(
                              child: assignedImage.isNotEmpty
                                  ? FadeInImage.assetNetwork(
                                      placeholder:
                                          'assets/images/placeholder-image.webp',
                                      image: assignedImage,
                                      fit: BoxFit.cover,
                                      width: 40,
                                      height: 40,
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/profile-placeholder.jpg',
                                          fit: BoxFit.cover,
                                          width: 40,
                                          height: 40,
                                        );
                                      },
                                    )
                                  : Image.asset(
                                      'assets/images/profile-placeholder.jpg',
                                      fit: BoxFit.cover,
                                      width: 40,
                                      height: 40,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
