import 'package:flutter/material.dart';

bool validateProjectFields({
  required TextEditingController projectNameController,
  required TextEditingController descriptionController,
  required TextEditingController numberImagesController,
  required TextEditingController projectDateController,
  required TextEditingController projectTimeController,
  required TextEditingController projectLocationController,
}) {
  if (projectNameController.text.trim().isEmpty) return false;
  if (descriptionController.text.trim().isEmpty) return false;
  if (numberImagesController.text.trim().isEmpty) return false;
  if (projectDateController.text.trim().isEmpty) return false;
  if (projectTimeController.text.trim().isEmpty) return false;
  if (projectLocationController.text.trim().isEmpty) return false;
  
  return true;
}