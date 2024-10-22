import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ProjectTaskFormScreen extends StatefulWidget {
  final String projectId;
  static const String name = "project_task_form_screen";

  const ProjectTaskFormScreen({super.key, required this.projectId});

  @override
  State<ProjectTaskFormScreen> createState() => _ProjectTaskFormScreenState();
}

class _ProjectTaskFormScreenState extends State<ProjectTaskFormScreen> {
  final TextEditingController _dueDateController = TextEditingController();
  String _status = 'To do';
  String _selectedPerson = 'Person 1';

  @override
  void dispose() {
    _dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: CustomColors.lightGrey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: CustomColors.darkGreen,
          centerTitle: false,
          title: Text(
            'Lonely Beach Pacific',
            style: TextStyle(
              fontSize: 22.0,
              color: const Color.fromARGB(255, 255, 255, 255),
              letterSpacing: 0.55,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              context.go('/projects/${widget.projectId}/tasks');
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create new Task',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green, // Fondo verde
                      shape: BoxShape
                          .circle, // Forma circular para que se vea como un botón redondo
                    ),
                    child: IconButton(
                      icon: Icon(Icons.replay, color: Colors.white, size: 30.0),
                      onPressed: () {
                        // Acción al presionar el ícono de limpiar
                      },
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
                  SizedBox(height: 8.0), // Espacio entre el texto y el input
                  TextFormField(
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
                      suffixIcon: Icon(Icons
                          .text_fields), // Ícono a la derecha del campo de texto
                    ),
                  ),
                  SizedBox(height: 20.0), // Espacio entre inputs
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
                  SizedBox(height: 8.0), // Espacio entre el texto y el input
                  TextFormField(
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
                  SizedBox(height: 8.0), // Espacio entre el texto y el input
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
                    iconSize: 35.0, // Aumenta el tamaño del ícono del dropdown
                    items: [
                      {
                        'value': 'Person 1',
                        'image': 'https://randomuser.me/api/portraits/men/1.jpg'
                      },
                      {
                        'value': 'Person 2',
                        'image':
                            'https://randomuser.me/api/portraits/women/2.jpg'
                      },
                      {
                        'value': 'Person 3',
                        'image': 'https://randomuser.me/api/portraits/men/3.jpg'
                      },
                      {
                        'value': 'Person 4',
                        'image':
                            'https://randomuser.me/api/portraits/women/4.jpg'
                      },
                    ].map((item) {
                      return DropdownMenuItem<String>(
                        value: item['value'] as String,
                        child: Row(
                          children: [
                            Container(
                              width: 35, // Aumenta el ancho de la imagen
                              height: 35, // Aumenta la altura de la imagen
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(item['image'] as String),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(item['value'] as String),
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
                                if (pickedDate != null) {
                                  // Formatea la fecha y actualiza el campo de texto
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  setState(() {
                                    // Actualiza el controlador del campo de texto con la fecha seleccionada
                                    _dueDateController.text = formattedDate;
                                  });
                                }
                              },
                              controller:
                                  _dueDateController, // Controlador para el campo de fecha
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
                                {'value': 'To do', 'color': Colors.red},
                                {
                                  'value': 'Progress',
                                  'color':
                                      const Color.fromARGB(255, 235, 214, 25)
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
                    width: double.infinity, // Ocupa todo el ancho disponible
                    child: Container(
                      decoration: BoxDecoration(
                          color: CustomColors.darkGreen, // Color de fondo
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: TextButton(
                        onPressed: () {
                          // Lógica para crear una nueva tarea
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, // Color del texto
                          textStyle: TextStyle(
                            fontSize: 20.0, // Aumenta el tamaño de la letra
                          ),
                        ),
                        child: Text('Create new task'),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0), // Espacio entre los botones
                  SizedBox(
                    height: 60,
                    width: double.infinity, // Ocupa todo el ancho disponible
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red, // Color de fondo
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: TextButton(
                        onPressed: () {
                          // Lógica para cancelar
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, // Color del texto
                          textStyle: TextStyle(
                            fontSize: 20.0, // Aumenta el tamaño de la letra
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
      ),
    );
  }
}
