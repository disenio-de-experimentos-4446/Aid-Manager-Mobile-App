import 'package:flutter/material.dart';

class Project {
  final int? id;
  DateTime? audit;
  final String name;
  final String description;
  final List<String> imageUrl;
  final int? companyId;
  final DateTime projectDate;
  final TimeOfDay projectTime;
  final String projectLocation;
  final List<dynamic>? userList;
  double? rating;
  bool isFavorite;

  Project({
    this.id,
    this.audit,
    this.userList,
    this.rating = 0.0,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.companyId,
    required this.projectDate,
    required this.projectTime,
    required this.projectLocation,
    bool? isFavorite,
  }) : isFavorite = isFavorite ?? false;
}