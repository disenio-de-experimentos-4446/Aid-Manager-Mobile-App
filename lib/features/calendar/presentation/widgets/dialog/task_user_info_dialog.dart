import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TaskUserInfoDialog extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String title;
  final String state;
  final int projectId;
  final DateTime assigneeAt;

  const TaskUserInfoDialog({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.title,
    required this.state,
    required this.projectId,
    required this.assigneeAt,
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
      return DateFormat('yyyy-MM-dd').format(date);
    }

    return AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.network(
              imageUrl,
              width: 125,
              height: 125,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/profile-placeholder.jpg',
                  width: 125,
                  height: 125,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          Text(
            name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timelapse_sharp, color: Colors.grey, size: 28.0),
              SizedBox(width: 10),
              Text(
                formatDate(assigneeAt),
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: getStatusColor(state),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 10),
              Text(
                state,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 30),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/projects/$projectId');
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.green.withOpacity(0.2),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
            ),
            child: const Text(
              'Go to project',
              style: TextStyle(fontSize: 18, color: CustomColors.darkGreen),
            ),
          ),
        ],
      ),
    );
  }
}