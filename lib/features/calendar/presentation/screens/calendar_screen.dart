import 'package:aidmanager_mobile/config/mocks/calendar_data.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/calendar/presentation/widgets/task_card.dart';
import 'package:flutter/material.dart';
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
  List<TaskItem> selectedTasks = [];

  @override
  void initState() {
    super.initState();
    _onDaySelected(today, today);
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      selectedTasks = _getTasksForDay(day);
    });
  }

  List<TaskItem> _getTasksForDay(DateTime day) {
    return tasksList.where((task) => isSameDay(task.date, day)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
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
                    right: 1/2,
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
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tasks for ${today.day} de Setiembre - ${today.year}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // evento para ir al proximo dia en el calendario
                  },
                  child: const Row(
                    children: [
                      Text(
                        'Next Day',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: CustomColors.darkGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5.0), // Espacio entre el texto y el ícono
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
                    status: task.status,
                  );
                },
              ),
            ),
          ))
        ],
      ),
    ));
  }
}
