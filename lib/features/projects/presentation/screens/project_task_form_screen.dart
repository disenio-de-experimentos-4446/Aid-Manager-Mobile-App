import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/profile/presentation/providers/profile_provider.dart';
import 'package:aidmanager_mobile/features/projects/presentation/providers/task_provider.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/tasks/dialog/error_task_creation_dialog.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/tasks/dialog/no_members_available_dialog.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/tasks/dialog/successfully_create_task_dialog.dart';
import 'package:aidmanager_mobile/shared/helpers/show_customize_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProjectTaskFormScreen extends StatefulWidget {
  final String projectId;
  final String projectName;
  static const String name = "project_task_form_screen";

  const ProjectTaskFormScreen(
      {super.key, required this.projectId, required this.projectName});

  @override
  State<ProjectTaskFormScreen> createState() => _ProjectTaskFormScreenState();
}

class _ProjectTaskFormScreenState extends State<ProjectTaskFormScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  String _status = 'ToDo';
  String? _selectedPerson;

  @override
  void initState() {
    super.initState();
    _loadMembers();
  }

  Future<void> _loadMembers() async {
    await context.read<ProfileProvider>().getMembersByCompany();
    if (!mounted) return;
    final users = context.read<ProfileProvider>().users;

    if (users.isEmpty) {
      showCustomizeDialog(context, NoMembersAvailableDialog());
      return;
    }

    setState(() {
      _selectedPerson = users[0].id.toString();
    });
  }

  Future<void> onSubmitNewTask() async {
    final subject = _subjectController.text.trim();
    final description = _descriptionController.text.trim();
    final dueDate =
        DateTime.tryParse(_dueDateController.text) ?? DateTime.now();
    final status = _status;
    final selectedPerson = _selectedPerson;

    final tasksProvider = context.read<TaskProvider>();

    try {
      await tasksProvider.createNewTask(
        subject,
        description,
        dueDate,
        status,
        int.parse(selectedPerson!),
        int.parse(widget.projectId),
      );

      if (!mounted) return;

      showCustomizeDialog(
          context,
          SuccessfullyCreateTaskDialog(
            projectId: widget.projectId,
            projectName: widget.projectName,
          ));
    } catch (e) {
      if (!mounted) return;
      showCustomizeDialog(context, ErrorTaskCreationDialog());
      return;
    }
  }

  @override
  void dispose() {
    _dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usersProvider = context.watch<ProfileProvider>();
    final tasksProvider = context.watch<TaskProvider>();
    final users = usersProvider.users;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: CustomColors.lightGrey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: CustomColors.darkGreen,
          centerTitle: false,
          title: Text(
            widget.projectName,
            style: TextStyle(
              fontSize: 22.0,
              color: const Color.fromARGB(255, 255, 255, 255),
              letterSpacing: 0.55,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              context.go(
                  '/projects/${widget.projectId}/tasks?name=${Uri.encodeComponent(widget.projectName)}');
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
        body: Stack(
          children: [
            SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Create new Task',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 45.0, // Ajusta el ancho del contenedor
                        height: 45.0, // Ajusta la altura del contenedor
                        decoration: BoxDecoration(
                          color: Colors.green, // Fondo verde
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.replay,
                              color: Colors.white, size: 28.0),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Subject',
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
                        controller: _subjectController,
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
                          suffixIcon: Icon(Icons.text_fields),
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
                      SizedBox(
                          height: 8.0), // Espacio entre el texto y el input
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
                          'Assigned To',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: CustomColors.darkGreen,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 8.0), // Espacio entre el texto y el input
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.5,
                                style: BorderStyle.solid),
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
                        iconSize:
                            35.0, // Aumenta el tamaño del ícono del dropdown
                        items: users.map((user) {
                          return DropdownMenuItem<String>(
                            value: user.id.toString(),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 35, // Aumenta el ancho de la imagen
                                  height: 35, // Aumenta la altura de la imagen
                                  child: ClipOval(
                                    child: user.profileImg != null
                                        ? FadeInImage.assetNetwork(
                                            placeholder:
                                                'assets/images/profile-placeholder.jpg',
                                            image: user.profileImg!,
                                            fit: BoxFit.cover,
                                            width: 35,
                                            height: 35,
                                            imageErrorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                'assets/images/profile-placeholder.jpg',
                                                fit: BoxFit.cover,
                                                width: 35,
                                                height: 35,
                                              );
                                            },
                                          )
                                        : Image.asset(
                                            'assets/images/profile-placeholder.jpg',
                                            fit: BoxFit.cover,
                                            width: 35,
                                            height: 35,
                                          ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  user.name,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedPerson = newValue!;
                          });
                        },
                        value: _selectedPerson,
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Due Date',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: CustomColors.darkGreen,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        8.0), // Espacio entre el texto y el input
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
                                  readOnly:
                                      true, // Hace que el campo sea de solo lectura
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    // Formatea la fecha y actualiza el campo de texto
                                    if (pickedDate != null) {
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      setState(() {
                                        // actualiza el controlador del campo de texto con la fecha seleccionada
                                        _dueDateController.text = formattedDate;
                                      });
                                    } else {
                                      // maneja el caso cuando pickedDate es nulo, si es necesario
                                      setState(() {
                                        _dueDateController.text = '';
                                      });
                                    }
                                  },
                                  controller: _dueDateController,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Status',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: CustomColors.darkGreen,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                DropdownButtonFormField<String>(
                                  iconSize: 25.0,
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
                                  items: [
                                    {'value': 'ToDo', 'color': Colors.red},
                                    {
                                      'value': 'Progress',
                                      'color': const Color.fromARGB(
                                          255, 235, 214, 25)
                                    },
                                    {'value': 'Done', 'color': Colors.green},
                                  ].map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item['value'] as String,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 15,
                                            height: 15,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: item['color'] as Color,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(item['value'] as String),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      _status = newValue!;
                                    });
                                  },
                                  value: _status,
                                  alignment: Alignment.centerLeft,
                                  dropdownColor: CustomColors.lightGrey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                              color: CustomColors.darkGreen,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          child: TextButton(
                            onPressed: () {
                              onSubmitNewTask();
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              textStyle: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            child: Text('Create new task'),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          child: TextButton(
                            onPressed: () {
                              // Lógica para cancelar
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              textStyle: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            child: Text('Cancel'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            if (usersProvider.isLoading || tasksProvider.isLoading)
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
