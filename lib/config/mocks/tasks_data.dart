class Task {
  final String title;
  final String description;
  String status;
  final String priority;
  final String imageUrl;
  final DateTime date;

  Task({
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.imageUrl,
    required this.date,
  });
}

final List<Task> tasksData = [
  Task(
    title: 'Design Landing Page',
    description: 'Create a landing page for the new product.',
    status: 'To do',
    priority: 'High',
    imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
    date: DateTime(2022, 10, 14),
  ),
  Task(
    title: 'Develop Login Feature',
    description: 'Implement login functionality using Firebase.',
    status: 'Progress',
    priority: 'Medium',
    imageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
    date: DateTime(2022, 10, 15),
  ),
  Task(
    title: 'Test Payment Gateway',
    description: 'Ensure the payment gateway is working correctly.',
    status: 'Done',
    priority: 'Low',
    imageUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
    date: DateTime(2022, 10, 16),
  ),
  Task(
    title: 'Write Documentation',
    description: 'Write comprehensive documentation for the project.',
    status: 'To do',
    priority: 'High',
    imageUrl: 'https://randomuser.me/api/portraits/women/4.jpg',
    date: DateTime(2022, 10, 17),
  ),
  Task(
    title: 'Fix Bugs',
    description: 'Fix bugs reported by the QA team.',
    status: 'Progress',
    priority: 'High',
    imageUrl: 'https://randomuser.me/api/portraits/men/5.jpg',
    date: DateTime(2022, 10, 18),
  ),
];


Map<String, List<Task>> classifiedTasks = classifyTasks(tasksData);

Map<String, List<Task>> classifyTasks(List<Task> tasks) {
  Map<String, List<Task>> classifiedTasks = {
    'To do': [],
    'Progress': [],
    'Done': [],
  };

  for (var task in tasks) {
    classifiedTasks[task.status]?.add(task);
  }

  return classifiedTasks;
}