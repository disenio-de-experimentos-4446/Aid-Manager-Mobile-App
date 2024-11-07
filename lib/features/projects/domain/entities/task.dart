class Task {
  int? id;
  String title;
  String description;
  DateTime? createdAt;
  DateTime dueDate;
  String state;
  int assigneeId;
  String? assigneeName;
  String? assignImage;
  int? projectId;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.createdAt,
    required this.dueDate,
    required this.state,
    required this.assigneeId,
    this.assigneeName,
    this.assignImage,
    this.projectId,
  });
}
