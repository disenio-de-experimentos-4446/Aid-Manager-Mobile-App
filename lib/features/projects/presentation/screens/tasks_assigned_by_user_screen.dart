import 'package:aidmanager_mobile/features/projects/presentation/providers/task_provider.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/tasks/task_user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';

class TasksAssignedByUserScreen extends StatefulWidget {
  static const String name = "tasks_assigned_by_user_screen";
  final String userId;
  final String userName;

  const TasksAssignedByUserScreen({super.key, required this.userId, required this.userName});

  @override
  State<TasksAssignedByUserScreen> createState() =>
      _TasksAssignedByUserScreenState();
}

class _TasksAssignedByUserScreenState extends State<TasksAssignedByUserScreen> {
  @override
  void initState() {
    super.initState();
    _loadTaskAssignnedByCurrentUser();
  }

  Future<void> _loadTaskAssignnedByCurrentUser() async {
    final taskProvider = context.read<TaskProvider>();

    await taskProvider
        .getTasksAssignedToUserInCompany(int.parse(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TaskProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.darkGreen,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 32.0,
          ),
          onPressed: () {
            context.pop(context);
          },
        ),
        title: Text(
          'Your tasks',
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
                            text: widget.userName,
                            style: TextStyle(
                              color: CustomColors.darkGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ', check your tasks assigned!',
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
          tasksProvider.initialLoading
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: tasksProvider.userTasks.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.comments_disabled_outlined,
                                  size: 48, color: Colors.grey),
                              SizedBox(height: 12),
                              Text(
                                'No tasks available',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  context.go('/tasks');
                                },
                                child: Text(
                                  'Go to tasks',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            top: 0.0,
                          ),
                          child: ListView.builder(
                            itemCount: tasksProvider.userTasks.length,
                            itemBuilder: (context, index) {
                              final task = tasksProvider.userTasks[index];
                              return Column(
                                children: [
                                  TaskUserCard(
                                    taskId: task.id!,
                                    assignedTo: task.assigneeId,
                                    title: task.title,
                                    description: task.description,
                                    dueDate: task.dueDate,
                                    assignedImage: task.assignImage!,
                                    onPressedCard: () {
                                      context.go('/tasks/${task.id}');
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                ),
        ],
      ),
    );
  }
}
