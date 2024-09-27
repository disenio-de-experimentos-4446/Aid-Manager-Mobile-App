import 'package:aidmanager_mobile/config/mocks/calendar_data.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final Status status;

  const TaskCard(
      {super.key,
      required this.title,
      required this.description,
      required this.status});

  @override
  Widget build(BuildContext context) {
    Color getStatusColor(Status status) {
      switch (status) {
        case Status.toDo:
          return const Color.fromARGB(255, 216, 66, 55);
        case Status.inProcess:
          return const Color.fromARGB(255, 236, 218, 48);
        case Status.done:
          return const Color.fromARGB(255, 58, 138, 61);
        default:
          return Colors.blue;
      }
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
                      const SizedBox(height: 5.0),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(
                Icons.info_outline_rounded,
                color: Colors.grey,
                size: 36.0,
              ),
              const SizedBox(width: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
