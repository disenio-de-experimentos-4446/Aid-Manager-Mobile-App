import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class ProjectCreateFormScreen extends StatefulWidget {
  static const String name = "project_create_form_screen";

  const ProjectCreateFormScreen({super.key});

  @override
  State<ProjectCreateFormScreen> createState() =>
      _ProjectCreateFormScreenState();
}

class _ProjectCreateFormScreenState extends State<ProjectCreateFormScreen> {
  final TextEditingController _projectDateController = TextEditingController();
  final TextEditingController _projectTimeController = TextEditingController();

  @override
  void dispose() {
    _projectDateController.dispose();
    _projectTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: CustomColors.darkGreen,
            centerTitle: false,
            title: Text(
              'Create new project',
              style: TextStyle(
                fontSize: 22.0,
                color: const Color.fromARGB(255, 255, 255, 255),
                letterSpacing: 0.55,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                context.go('/projects');
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
                        'Number of Images',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: CustomColors.darkGreen,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0), // Espacio entre el texto y el input
                    TextFormField(
                      keyboardType: TextInputType.number,
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
                            .image), // Ícono a la derecha del campo de texto
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
                            .location_on), // Ícono a la derecha del campo de texto
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
                                      _projectDateController.text =
                                          formattedDate;
                                    });
                                  }
                                },
                                controller:
                                    _projectDateController, // Controlador para el campo de fecha
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 15.0), // Espacio entre los dos campos
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
                                  suffixIcon: Icon(Icons.access_time),
                                ),
                                readOnly:
                                    true, // Hace que el campo sea de solo lectura
                                onTap: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (pickedTime != null) {
                                    // Formatea la hora y actualiza el campo de texto
                                    String formattedTime =
                                        pickedTime.format(context);
                                    setState(() {
                                      // Actualiza el controlador del campo de texto con la hora seleccionada
                                      _projectTimeController.text =
                                          formattedTime;
                                    });
                                  }
                                },
                                controller:
                                    _projectTimeController, // Controlador para el campo de hora
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
                      width: double.infinity, // Ocupa todo el ancho disponible
                      child: Container(
                        decoration: BoxDecoration(
                          color: CustomColors.darkGreen, // Color de fondo
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Lógica para crear un nuevo proyecto
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white, // Color del texto
                            textStyle: TextStyle(
                              fontSize: 20.0, // Aumenta el tamaño de la letra
                            ),
                          ),
                          child: Text(
                            'Create a project',
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0), // Espacio entre los botones
                    SizedBox(
                      height: 60,
                      width: double.infinity, // Ocupa todo el ancho disponible
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red, // Color de fondo
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
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
          )),
    );
  }
}
