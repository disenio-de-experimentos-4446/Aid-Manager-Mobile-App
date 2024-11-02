import 'package:aidmanager_mobile/features/calendar/presentation/widgets/dialog/task_user_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String status;
  final int projectId;
  final String assigneeName;
  final String assigneeImage;
  final DateTime assigneeAt;
  final DateTime createdAt;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    required this.projectId,
    required this.assigneeName,
    required this.assigneeImage,
    required this.assigneeAt,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    Color getStatusColor(String status) {
      switch (status) {
        case 'ToDo':
          return const Color.fromARGB(255, 216, 66, 55);
        case 'Progress':
          return const Color.fromARGB(255, 236, 218, 48);
        case 'Done':
          return const Color.fromARGB(255, 58, 138, 61);
        default:
          return Colors.blue;
      }
    }

    String formatDate(DateTime date) {
      return DateFormat('dd MMM yyyy').format(date);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        height: 100,
        child: Card(
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Container(
                width: 15.0,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: getStatusColor(status),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '${formatDate(createdAt)} - ${formatDate(assigneeAt)}',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TaskUserInfoDialog(
                        imageUrl: assigneeImage,
                        name: assigneeName,
                        title: title,
                        state: status,
                        projectId: projectId,
                        assigneeAt: assigneeAt,
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.info_outline_rounded,
                  color: Colors.grey,
                  size: 34.0,
                ),
              ),
              const SizedBox(width: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
