class Project {
  final int? id;
  final String name;
  final String description;
  final List<String> imageUrl;
  final int? companyId;
  final DateTime projectDate;
  final String projectTime;
  final String projectLocation;
  final List<dynamic>? userList;

  Project({
    this.id,
    this.userList,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.companyId,
    required this.projectDate,
    required this.projectTime,
    required this.projectLocation,
  });
}
