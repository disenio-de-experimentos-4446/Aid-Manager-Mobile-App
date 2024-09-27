enum Status { toDo, inProcess, done }

class TaskItem {
  final DateTime date;
  final String title;
  final String description;
  final Status status;

  TaskItem({
    required this.date,
    required this.title,
    required this.description,
    required this.status,
  });
}

final List<TaskItem> tasksList = [
  TaskItem(
    date: DateTime(2024, 9, 25),
    title: 'University Report',
    description: 'working in university report for sigma',
    status: Status.done,
  ),
  TaskItem(
    date: DateTime(2024, 9, 25),
    title: 'Meeting with Team',
    description: 'Discuss project milestones',
    status: Status.inProcess,
  ),
  TaskItem(
    date: DateTime(2024, 12, 25),
    title: 'Code Review',
    description: 'Review code for the new feature',
    status: Status.toDo,
  ),
  TaskItem(
    date: DateTime(2024, 9, 26),
    title: 'Client Presentation',
    description: 'Present the project to the client',
    status: Status.done,
  ),
  TaskItem(
    date: DateTime(2024, 9, 26),
    title: 'Design Meeting',
    description: 'Discuss the new design mockups',
    status: Status.inProcess,
  ),
  TaskItem(
    date: DateTime(2024, 9, 26),
    title: 'Write Documentation',
    description: 'Document the API endpoints',
    status: Status.toDo,
  ),
  TaskItem(
    date: DateTime(2024, 9, 27),
    title: 'Testing',
    description: 'Test the new release',
    status: Status.done,
  ),
  TaskItem(
    date: DateTime(2024, 9, 27),
    title: 'Bug Fixing',
    description: 'Fix bugs reported by QA',
    status: Status.inProcess,
  ),
  TaskItem(
    date: DateTime(2024, 9, 27),
    title: 'Deploy to Staging',
    description: 'Deploy the new version to staging',
    status: Status.toDo,
  ),
  TaskItem(
    date: DateTime(2024, 9, 25),
    title: 'Update Dependencies',
    description: 'Update project dependencies to latest versions',
    status: Status.done,
  ),
  TaskItem(
    date: DateTime(2024, 9, 25),
    title: 'Team Lunch',
    description: 'Lunch with the team at the new restaurant',
    status: Status.inProcess,
  ),
  TaskItem(
    date: DateTime(2023, 9, 25),
    title: 'Brainstorming Session',
    description: 'Brainstorm ideas for the new project',
    status: Status.toDo,
  ),
  TaskItem(
    date: DateTime(2024, 9, 26),
    title: 'One-on-One Meeting',
    description: 'One-on-one meeting with the manager',
    status: Status.done,
  ),
  TaskItem(
    date: DateTime(2024, 9, 26),
    title: 'Code Optimization',
    description: 'Optimize the code for better performance',
    status: Status.inProcess,
  ),
  TaskItem(
    date: DateTime(2024, 9, 26),
    title: 'Security Audit',
    description: 'Conduct a security audit of the application',
    status: Status.toDo,
  ),
  TaskItem(
    date: DateTime(2024, 9, 27),
    title: 'Refactor Codebase',
    description: 'Refactor the codebase for better readability',
    status: Status.done,
  ),
  TaskItem(
    date: DateTime(2024, 9, 27),
    title: 'User Feedback',
    description: 'Collect feedback from users',
    status: Status.inProcess,
  ),
  TaskItem(
    date: DateTime(2024, 9, 27),
    title: 'Plan Sprint',
    description: 'Plan the tasks for the next sprint',
    status: Status.toDo,
  ),
  TaskItem(
    date: DateTime(2024, 9, 25),
    title: 'Update Roadmap',
    description: 'Update the project roadmap',
    status: Status.done,
  ),
  TaskItem(
    date: DateTime(2024, 9, 25),
    title: 'Client Call',
    description: 'Call with the client to discuss requirements',
    status: Status.inProcess,
  ),
  TaskItem(
    date: DateTime(2024, 9, 25),
    title: 'Research',
    description: 'Research new technologies for the project',
    status: Status.toDo,
  ),
  TaskItem(
    date: DateTime(2024, 9, 26),
    title: 'Write Tests',
    description: 'Write unit tests for the new feature',
    status: Status.done,
  ),
  TaskItem(
    date: DateTime(2024, 9, 26),
    title: 'Team Meeting',
    description: 'Weekly team meeting',
    status: Status.inProcess,
  ),
  TaskItem(
    date: DateTime(2024, 9, 26),
    title: 'Update Wiki',
    description: 'Update the project wiki with new information',
    status: Status.toDo,
  ),
  TaskItem(
    date: DateTime(2024, 9, 27),
    title: 'Performance Review',
    description: 'Conduct performance reviews for the team',
    status: Status.done,
  ),
  TaskItem(
    date: DateTime(2024, 9, 27),
    title: 'Database Migration',
    description: 'Migrate the database to the new server',
    status: Status.inProcess,
  ),
  TaskItem(
    date: DateTime(2024, 9, 27),
    title: 'Create Backup',
    description: 'Create a backup of the current database',
    status: Status.toDo,
  ),
];