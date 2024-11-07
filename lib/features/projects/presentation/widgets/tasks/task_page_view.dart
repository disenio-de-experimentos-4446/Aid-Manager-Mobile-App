import 'package:aidmanager_mobile/features/projects/domain/entities/task.dart';
import 'package:aidmanager_mobile/features/projects/shared/helpers/get_random_priority.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskPageView extends StatelessWidget {
  final List<Task> tasks;
  final Function(int projectId, int taskId, String newStatus) onUpdateStatus;

  const TaskPageView({
    super.key,
    required this.tasks,
    required this.onUpdateStatus,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            final assignImage = task.assignImage ?? '';
            final priority = getPriorityFromDueDate(task.dueDate);
            final color = getPriorityColor(priority);

            return Column(
              children: [
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.black54, width: 1),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                task.title,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              icon: Icon(
                                Icons.more_horiz,
                                size: 34.0,
                              ),
                              onSelected: (String newStatus) {
                                onUpdateStatus(
                                    task.projectId!, task.id!, newStatus);
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'ToDo',
                                  child: Text(
                                    'To do',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Progress',
                                  child: Text(
                                    'Progress',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Done',
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          task.description,
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
                                    DateFormat('yyyy-MM-dd')
                                        .format(task.dueDate),
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 41, 41,
                                        41), // Color de fondo del contenedor
                                    borderRadius: BorderRadius.circular(
                                        20), // Bordes redondeados
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 6),
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
                                    color: const Color.fromARGB(
                                        255, 219, 219, 219),
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.green,
                                    child: ClipOval(
                                      child: assignImage.isNotEmpty
                                          ? FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/images/placeholder-image.webp',
                                              image: task.assignImage ??
                                                  'assets/images/profile-placeholder.jpg',
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
          },
        ),
      ),
    );
  }
}
