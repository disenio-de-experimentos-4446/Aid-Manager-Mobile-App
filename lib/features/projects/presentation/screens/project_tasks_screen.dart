import 'package:aidmanager_mobile/config/mocks/tasks_data.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/tasks/task_page_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectTasksScreen extends StatefulWidget {
  static const String name = "project_tasks_screen";
  final String projectId;

  const ProjectTasksScreen({super.key, required this.projectId});

  @override
  State<ProjectTasksScreen> createState() => _ProjectTasksScreenState();
}

class _ProjectTasksScreenState extends State<ProjectTasksScreen> {
  String selectedButton = 'To do';
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  void handleButtonPress(int pageIndex, String buttonText) {
    setState(() {
      currentPage = pageIndex;
      selectedButton = buttonText;
      pageController.jumpToPage(pageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.darkGreen,
        centerTitle: false,
        title: Text(
          'Lonely Beach Pacific',
          style: TextStyle(
            fontSize: 22.0,
            color: const Color.fromARGB(255, 255, 255, 255),
            letterSpacing: 0.55,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            context.go('/projects/${widget.projectId}');
          },
        ),
        toolbarHeight: 70.0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.white,
              size: 32.0,
            ),
            onPressed: () {
              // Acción al presionar el ícono de tres puntos
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color.fromARGB(255, 134, 134, 134),
                  width: 1.0, // Ancho del borde
                ),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomButton(
                        text: 'To do',
                        number: tasksData
                            .where((task) => task.status == 'To do')
                            .length,
                        color: const Color.fromARGB(255, 255, 141, 132),
                        isSelected: selectedButton == 'To do',
                        onPressed: () {
                          handleButtonPress(0, 'To do');
                        },
                      ),
                      SizedBox(width: 20), // Espacio entre botones
                      CustomButton(
                        text: 'Progress',
                        number: tasksData
                            .where((task) => task.status == 'Progress')
                            .length,
                        color: const Color.fromARGB(255, 229, 255, 0),
                        isSelected: selectedButton == 'Progress',
                        onPressed: () {
                          handleButtonPress(1, 'Progress');
                        },
                      ),
                      SizedBox(width: 20), // Espacio entre botones
                      CustomButton(
                        text: 'Complete',
                        number: tasksData
                            .where((task) => task.status == 'Done')
                            .length,
                        color: const Color.fromARGB(255, 92, 212, 96),
                        isSelected: selectedButton == 'Complete',
                        onPressed: () {
                          handleButtonPress(2, 'Complete');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                  switch (page) {
                    case 0:
                      selectedButton = 'To do';
                      break;
                    case 1:
                      selectedButton = 'Progress';
                      break;
                    case 2:
                      selectedButton = 'Complete';
                      break;
                  }
                });
              },
              children: [
                TaskPageView(
                  tasks: tasksData
                      .where((task) => task.status == 'To do')
                      .toList(),
                ),
                TaskPageView(
                  tasks: tasksData
                      .where((task) => task.status == 'Progress')
                      .toList(),
                ),
                TaskPageView(
                  tasks:
                      tasksData.where((task) => task.status == 'Done').toList(),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            context.go('/projects/${widget.projectId}/tasks/new');
        },
        backgroundColor: CustomColors.darkGreen,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final int number;
  final Color color;
  final bool isSelected;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.number,
    required this.color,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black87 : Colors.white,
          border: Border.all(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                number.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
