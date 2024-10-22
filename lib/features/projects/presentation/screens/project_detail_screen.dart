import 'dart:ui';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ProjectDetailScreen extends StatelessWidget {
  static const String name = "project_detail_screen";
  final String projectId;

  const ProjectDetailScreen({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black.withOpacity(0.5),
    ));

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                "assets/images/project-example.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 20, sigmaY: 20), // Desenfoque más fuerte
                  child: Container(
                    color: Colors.black.withOpacity(0.3), // Menos oscuro
                    padding: EdgeInsets.all(
                        10.0), // Añadir padding para centrar el icono
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          context.go('/projects');
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20.0,
              right: 20.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Fondo blanco para el botón
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.black87,
                    size: 34.0,
                  ),
                  onPressed: () {
                    // Acción del botón
                  },
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.6,
              maxChildSize: 1.0,
              minChildSize: 0.6,
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: CustomColors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 5,
                                width: 45,
                                color: Colors.black12,
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                'Spacious 3BR House in Jakarta',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow
                                    .ellipsis, // Añadir elipsis si el texto es demasiado largo
                                maxLines: 2, // Permitir hasta 2 líneas
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[800],
                                  size: 28.0,
                                ),
                                SizedBox(
                                    width:
                                        5.0), // Espacio entre el icono y el texto
                                Text(
                                  '4.5', // Número de puntuación
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.black.withOpacity(0.6),
                              size: 18.0,
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              'Lima, Perú',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            SizedBox(width: 14.0),
                            Container(
                              width: 6.0,
                              height: 6.0,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 14.0),
                            Icon(
                              Icons.calendar_today,
                              color: Colors.black.withOpacity(0.6),
                              size: 18.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '12-03-24',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            SizedBox(width: 14.0),
                            Container(
                              width: 6.0,
                              height: 6.0,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 14.0),
                            Icon(
                              Icons.timer_sharp,
                              color: Colors.black.withOpacity(0.6),
                              size: 18.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '12:02',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    color: CustomColors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 0.5,
                                      color: CustomColors.grey,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      'assets/images/aidmanager_logo.png',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Auspiced By',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'AidManager',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.darkGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(
                                        0.1), // Color de fondo con opacidad
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Bordes suaves
                                    border: Border.all(
                                      color: Colors.blue
                                          .withOpacity(0.5), // Color del borde
                                      width: 1.0,
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.globe,
                                      size: 28.0,
                                    ),
                                    color: Colors.blue,
                                    onPressed: () {
                                      // Acción del botón de sitio web
                                    },
                                  ),
                                ),
                                SizedBox(
                                    width: 12.0), // Espacio entre los botones
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(
                                        0.1), // Color de fondo con opacidad
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Bordes suaves
                                    border: Border.all(
                                      color: Colors.red
                                          .withOpacity(0.5), // Color del borde
                                      width: 1.0,
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.email,
                                      size: 30.0,
                                    ),
                                    color: Colors.red,
                                    onPressed: () {
                                      // Acción del botón de correo
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          color: const Color.fromARGB(255, 212, 211, 211),
                          thickness: 2.0,
                          height: 35,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'About Project',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .go('/projects/$projectId/dashboard');
                                  },
                                  child: Text(
                                    'See Metrics',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: CustomColors.darkGreen,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 18.0,
                                  color: CustomColors.darkGreen,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur adipiscing elit mollis, congue vivamus hendrerit elementum in nam facilisis.',
                          style: TextStyle(fontSize: 18.0, height: 1.65),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColors.lightGrey,
                            borderRadius: BorderRadius.circular(
                                15.0), // Bordes redondeados
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 187, 185, 185)
                                    .withOpacity(0.5),
                                spreadRadius: 1.5,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 1), // Desplazamiento de la sombra
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.maps_home_work_sharp,
                                            color: Colors.indigo[600],
                                            size: 32.0,
                                          ),
                                          SizedBox(width: 12.0),
                                          Text(
                                            '1234 Elm Street, Springfield, USA',
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: CustomColors.darkGreen,
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color:
                                      const Color.fromARGB(255, 199, 195, 195),
                                  thickness: 1.5,
                                  height: 35.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.date_range_sharp,
                                        color: Colors.blue[700],
                                        size: 32.0,
                                      ),
                                      SizedBox(width: 12.0),
                                      Text(
                                        'From: Jan 1, 2023 - To: Jan 10, 2023',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: const Color.fromARGB(
                                                200, 0, 0, 0)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '123 ', // Número
                                      style: TextStyle(
                                        color: Colors.green, // Color del número
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' interested', // Texto
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 53, 52, 52),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '45', // Número
                                      style: TextStyle(
                                        color: Colors.green, // Color del número
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' members', // Texto
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 53, 52, 52),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '75%', // Número
                                      style: TextStyle(
                                        color: Colors.green, // Color del número
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' recaudation', // Texto
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 53, 52, 52),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Divider(
                          color: const Color.fromARGB(255, 212, 211, 211),
                          thickness: 2.0,
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Collaborators',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.go('/projects/$projectId/tasks');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 16, 85, 68),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 20.0),
                              ),
                              child: Text(
                                'Assign Tasks',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _CollaboratorShape(
                                  'assets/images/hotman-placeholder.jpg'),
                              _CollaboratorShape(
                                  'assets/images/hotman-placeholder.jpg'),
                              _CollaboratorShape(
                                  'assets/images/hotman-placeholder.jpg'),
                              _CollaboratorShape(
                                  'assets/images/hotman-placeholder.jpg'),
                              _CollaboratorShape(
                                  'assets/images/hotman-placeholder.jpg'),
                              _CollaboratorShape(
                                  'assets/images/hotman-placeholder.jpg'),
                              _CollaboratorShape(
                                  'assets/images/hotman-placeholder.jpg'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          color: const Color.fromARGB(255, 212, 211, 211),
                          thickness: 2.0,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        _ProjectHighlights(),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class _ProjectHighlights extends StatelessWidget {
  const _ProjectHighlights();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Project Highlights',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  'More Details',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: CustomColors.darkGreen,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 18.0,
                  color: CustomColors.darkGreen,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tasks Completed:',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Amount Raised:',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Volunteers:',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Status:',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Project Type:',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '25 per month',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '\$10,000 dollars',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '150',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'In progress',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Benefic',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CollaboratorShape extends StatelessWidget {
  final String imagePath;

  const _CollaboratorShape(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.0),
      child: Container(
        width: 75.0,
        height: 75.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color.fromARGB(255, 92, 92, 92), // Borde gris
            width: 2.0,
          ),
        ),
        child: ClipOval(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.10), // Fondo opaco
              BlendMode.darken,
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
