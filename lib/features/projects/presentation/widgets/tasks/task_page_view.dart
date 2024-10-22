import 'package:aidmanager_mobile/config/mocks/tasks_data.dart';
import 'package:flutter/material.dart';

class TaskPageView extends StatelessWidget {
  final List<Task> tasks;

  const TaskPageView({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Column(
              children: [
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                        color: Colors.black54,
                        width: 1), // Borde negro
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                task.title,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              icon: Icon(
                                Icons.more_horiz,
                                size: 34.0,
                              ),
                              onSelected: (String newStatus) {
                                // actualizar el estado de la tarea
                                task.status = newStatus;
                                // Notificar a la interfaz de usuario que se ha actualizado el estado
                                (context as Element).markNeedsBuild();
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'To do',
                                  child: Text('To do', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Progress',
                                  child: Text('Progress', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Done',
                                  child: Text('Done', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          task.description,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_today),
                                SizedBox(width: 8),
                                Transform.translate(
                                  offset: Offset(0,
                                      1), // Desplazamiento en el eje Y negativo
                                  child: Text(
                                    '${task.date.day}/${task.date.month}/${task.date.year}', // Fecha de la tarea
                                    style: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 41, 41,
                                        41), // Color de fondo del contenedor
                                    borderRadius: BorderRadius.circular(
                                        20), // Bordes redondeados
                                  ),
                                  child: Text(
                                    'Risk', // Texto del contenedor
                                    style: TextStyle(
                                      color: Colors.white, // Color del texto
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 224, 64,
                                        64), // Color de fondo del contenedor
                                    borderRadius: BorderRadius.circular(
                                        20), // Bordes redondeados
                                  ),
                                  child: Text(
                                    task.priority, // Prioridad de la tarea
                                    style: TextStyle(
                                      color: Colors.white, // Color del texto
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.all(
                                      1.5), // Espacio entre el borde y el avatar
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 219, 219, 219), // Color del borde
                                    shape: BoxShape.circle, // Forma circular
                                  ),
                                  child: CircleAvatar(
                                    radius: 20, // Tamaño del avatar
                                    backgroundImage:
                                        NetworkImage(task.imageUrl),
                                    backgroundColor: Colors
                                        .green, // Color de fondo si la imagen no se carga
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
