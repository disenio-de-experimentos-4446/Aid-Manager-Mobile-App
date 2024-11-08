import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/calendar/presentation/providers/calendar_provider.dart';
import 'package:aidmanager_mobile/features/calendar/presentation/widgets/task_card.dart';
import 'package:aidmanager_mobile/features/calendar/shared/widgets/custom_error_calendar_dialog.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  static const String name = "calendar_screen";

  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const CalendarContent(),
        );
      },
    );
  }
}

class CalendarContent extends StatefulWidget {
  const CalendarContent({super.key});

  @override
  State<CalendarContent> createState() => _CalendarContentState();
}

class _CalendarContentState extends State<CalendarContent> {
  DateTime today = DateTime.now();
  List<Task> selectedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasksForCalendar();
    _onDaySelected(today, today);
  }

  Future<void> _loadTasksForCalendar() async {
    final calendarProvider =
        Provider.of<CalendarProvider>(context, listen: false);
    try {
      await calendarProvider.loadAllTasks();
    } catch (e) {
      if (!mounted) return;
      // mostrar un dialog perzonalizado para cada exception
      final dialog = getCalendarErrorDialog(context, e as Exception);
      showErrorDialog(context, dialog);
    }
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      selectedTasks = _getTasksForDay(day);
    });
  }

  List<Task> _getTasksForDay(DateTime day) {
    final calendarProvider =
        Provider.of<CalendarProvider>(context, listen: false);
    final tasks = calendarProvider.tasks;
    return tasks.where((task) => isSameDay(task.dueDate, day)).toList();
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  DateTime? getNextTaskDate() {
    final calendarProvider =
        Provider.of<CalendarProvider>(context, listen: false);
    final tasks = calendarProvider.tasks;

    // filtra las tareas que tienen una fecha de vencimiento posterior a 'today'
    final sortedTasks = tasks
        .where((task) => task.dueDate.isAfter(today))
        .toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));

    // devuelve la fecha de vencimiento de la primera tarea en la lista
    return sortedTasks.isNotEmpty ? sortedTasks.first.dueDate : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
            child: Column(
              children: [
                TableCalendar(
                  locale: "en_US",
                  rowHeight: 55,
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      color: CustomColors.darkGreen,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.green,
                      size: 28.0,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.green,
                      size: 28.0,
                    ),
                    headerMargin: EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  focusedDay: today,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  onDaySelected: _onDaySelected,
                  calendarStyle: const CalendarStyle(
                    isTodayHighlighted: false,
                    selectedDecoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      if (events.isNotEmpty) {
                        return Positioned(
                          left: 0,
                          bottom: 2,
                          right: 1 / 2,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            width: 10.0,
                            height: 10.0,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  // cargar los eventos para un dia en especifico
                  eventLoader: _getTasksForDay,
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tasks for ${today.day} de ${DateFormat('MMMM').format(today)} - ${today.year}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          final nextTaskDate = getNextTaskDate();
                          if (nextTaskDate != null) {
                            _onDaySelected(nextTaskDate, nextTaskDate);
                          }
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 17.0,
                                color: CustomColors.darkGreen,
                                letterSpacing: 0.65,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: CustomColors.darkGreen,
                              size: 16.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: ListView.builder(
                      itemCount: selectedTasks.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final task = selectedTasks[index];
                        return TaskCard(
                          title: task.title,
                          description: task.description,
                          status: task.state,
                          projectId: task.projectId!,
                          assigneeName: task.assigneeName!,
                          assigneeImage: task.assignImage!,
                          assigneeAt: task.dueDate,
                          createdAt: task.createdAt!,
                        );
                      },
                    ),
                  ),
                ))
              ],
            ),
          ),
          Consumer<CalendarProvider>(
            builder: (context, authProvider, child) {
              return authProvider.initialLoading
                  ? Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: CircularProgressIndicator(
                            strokeWidth: 8,
                            color: CustomColors.darkGreen,
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
