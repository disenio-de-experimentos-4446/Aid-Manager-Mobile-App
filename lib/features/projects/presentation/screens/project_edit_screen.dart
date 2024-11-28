import 'package:aidmanager_mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/is_empty_dialog.dart';
import 'package:aidmanager_mobile/features/projects/domain/entities/project.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/project/dialog/successfully_project_update_dialog.dart';
import 'package:aidmanager_mobile/features/projects/shared/widgets/custom_error_project_dialog.dart';
import 'package:aidmanager_mobile/shared/helpers/show_customize_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/projects/presentation/providers/project_provider.dart';

class ProjectEditScreen extends StatefulWidget {
  static const String name = "project_edit_form_screen";
  final String projectId;
  final Project project;

  const ProjectEditScreen({
    super.key,
    required this.projectId,
    required this.project,
  });

  @override
  State<ProjectEditScreen> createState() => _ProjectEditScreenState();
}

class _ProjectEditScreenState extends State<ProjectEditScreen> {
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _projectDateController = TextEditingController();
  final TextEditingController _projectTimeController = TextEditingController();
  final TextEditingController _projectLocation = TextEditingController();

  @override
  void initState() {
    super.initState();
    _projectNameController.text = widget.project.name;
    _descriptionController.text = widget.project.description;
    _projectDateController.text =
        DateFormat('yyyy-MM-dd').format(widget.project.projectDate);
    _projectLocation.text = widget.project.projectLocation;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _projectTimeController.text = widget.project.projectTime.format(context);
  }

  Future<void> onSubmitEditProject() async {
    if (_projectNameController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _projectDateController.text.trim().isEmpty ||
        _projectTimeController.text.trim().isEmpty ||
        _projectLocation.text.trim().isEmpty) {
      showErrorDialog(
        context,
        const IsEmptyDialog(),
      );
      return;
    }

    final name = _projectNameController.text.trim();
    final description = _descriptionController.text.trim();
    final projectDate =
        DateTime.tryParse(_projectDateController.text) ?? DateTime.now();
    final timeParts = _projectTimeController.text.split(":");
    final projectTime = timeParts.length == 2
        ? TimeOfDay(
            hour: int.tryParse(timeParts[0]) ?? 0,
            minute: int.tryParse(timeParts[1]) ?? 0,
          )
        : TimeOfDay(hour: 0, minute: 0);
    final projectLocation = _projectLocation.text.trim();

    final projectProvider = context.read<ProjectProvider>();

    try {
      await projectProvider.updateProject(
        int.parse(widget.projectId),
        name,
        description,
        widget.project
            .imageUrl, // mandamos el mismo, esto no se podra actualizar :p
        projectDate,
        projectTime,
        projectLocation,
      );

      if (!mounted) return;

      showCustomizeDialog(context, const SuccessfullyProjectUpdateDialog());
    } catch (e) {
      if (!mounted) return;
      final dialog = getProjectErrorDialog(context, e as Exception);
      showErrorDialog(context, dialog);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AuthProvider>(context).user;
    final projectProvider = context.watch<ProjectProvider>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: CustomColors.darkGreen,
          centerTitle: false,
          title: Text(
            'Edit "${widget.project.name}"',
            style: TextStyle(
              fontSize: 22.0,
              color: const Color.fromARGB(255, 255, 255, 255),
              letterSpacing: 0.65,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              context.go('/projects/user/${currentUser!.id}');
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
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 25.0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            letterSpacing: 0.60,
                            color: CustomColors.darkGreen,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _projectNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: CustomColors.darkGreen,
                              width: 2.0,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Icon(Icons.title),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: CustomColors.darkGreen,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 4, // Campo de descripción
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: CustomColors.darkGreen,
                              width: 2.0,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Project Location',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: CustomColors.darkGreen,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _projectLocation,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: CustomColors.darkGreen,
                              width: 2.0,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Icon(Icons.location_on),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Project Date',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: CustomColors.darkGreen,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1.5,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1.5,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: CustomColors.darkGreen,
                                        width: 2.0,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: widget.project.projectDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      setState(() {
                                        _projectDateController.text =
                                            formattedDate;
                                      });
                                    }
                                  },
                                  controller: _projectDateController,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 15.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Project Time',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: CustomColors.darkGreen,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1.5,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1.5,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: CustomColors.darkGreen,
                                        width: 2.0,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: Icon(Icons.access_time),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (pickedTime != null) {
                                      String formattedTime =
                                          pickedTime.format(context);
                                      setState(() {
                                        // Actualiza el controlador del campo de texto con la hora seleccionada
                                        _projectTimeController.text =
                                            formattedTime;
                                      });
                                    }
                                  },
                                  controller: _projectTimeController,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  Column(
                    children: [
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomColors.darkGreen, // Color de fondo
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: TextButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              onSubmitEditProject();
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white, // Color del texto
                              textStyle: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            child: Text(
                              'Update project',
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red, // Color de fondo
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: TextButton(
                            onPressed: () {
                              context.go('/projects/user/${currentUser!.id}');
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              textStyle: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            if (projectProvider.initialLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      strokeWidth: 8,
                      color: CustomColors
                          .darkGreen, // Puedes cambiar el color aquí
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
