import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostDetailScreen extends StatelessWidget {
  final String postId;
  static const String name = "posts_detail_screen";

  const PostDetailScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.0,
        automaticallyImplyLeading:
            false, // Elimina el botón de retroceso predeterminado
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                context.go('/posts');
              },
              child: Icon(
                Icons.arrow_back_rounded,
                size: 32.0,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.save,
                    size: 32.0,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Lógica para guardar
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    size: 32.0,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Lógica para agregar a favoritos
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: CustomColors.grey, // Color del borde
                    width: 2.0, // Ancho del borde
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 30.0, top: 0.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  'https://avatars.githubusercontent.com/u/129230632?v=4'), // URL de la imagen de perfil
                            ),
                            SizedBox(width: 12.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize
                                  .min, // Reduce el tamaño del eje principal
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize
                                      .min, // Reduce el tamaño del eje principal del Row
                                  children: [
                                    Text(
                                      'Sebastian Hotman',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            14), // Ajusta el espacio entre el texto y el botón
                                    TextButton.icon(
                                      onPressed: () {
                                        // Lógica para el botón de autor
                                      },
                                      icon: Icon(Icons.person, size: 22.0),
                                      label: Text('Autor'),
                                      style: TextButton.styleFrom(
                                        foregroundColor: CustomColors.darkGreen,
                                        textStyle: TextStyle(
                                          fontSize: 18.0,
                                        ),
                                        padding: EdgeInsets
                                            .zero, // Elimina el padding del botón
                                        minimumSize: Size(0,
                                            0), // Elimina el tamaño mínimo del botón
                                      ),
                                    ),
                                  ],
                                ),
                                Transform.translate(
                                  offset: Offset(0, -5),
                                  child: Text(
                                    'nekito@example.com',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 14),
                        Text(
                          'Me siento mal porque he traicionado la confianza de mi mejor amigo, Yesi, al enamorarme de su exnovia, Flavia. Después de confesarle mis sentimientos, decidí priorizar nuestra amistad. Aprendí que la verdadera lealtad es más valiosa que cualquier deseo personal.',
                          style: TextStyle(fontSize: 16.0, height: 1.65),
                        ),
                        SizedBox(height: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            'https://img.europapress.es/fotoweb/fotonoticia_20191014112917_1200.jpg',
                            width: double.infinity,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.comment,
                                        size: 22.0,
                                        color: const Color.fromARGB(
                                            255, 114, 114, 114)),
                                    SizedBox(width: 5),
                                    Text(
                                      '24 reviews',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: const Color.fromARGB(
                                            255, 75, 75, 75),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.thumb_up_rounded,
                                        size: 22.0,
                                        color: const Color.fromARGB(
                                            255, 114, 114, 114)),
                                    SizedBox(width: 5),
                                    Text(
                                      '24 likes',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                        color: const Color.fromARGB(
                                            255, 75, 75, 75),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_month,
                                    size: 20.0,
                                    color: const Color.fromARGB(
                                        255, 114, 114, 114)),
                                SizedBox(width: 6),
                                Text(
                                  '14 Oct 2019',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color:
                                        const Color.fromARGB(255, 75, 75, 75),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey, // Color del borde inferior
                    width: 1.0, // Ancho del borde inferior
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              'https://github.com/AplicacionesWeb-WX54/si730-WX54-Grupo1-Repository/blob/main/assets/members-profile/arigeimpleis.jpg?raw=true'),
                        ),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize
                              .min, // Reduce el tamaño del eje principal
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize
                                  .min, // Reduce el tamaño del eje principal del Row
                              children: [
                                Text(
                                  'Arian Rodriguez',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                    width:
                                        14), // Ajusta el espacio entre el texto y el botón
                                TextButton.icon(
                                  onPressed: () {
                                    // Lógica para el botón de autor
                                  },
                                  icon: Container(
                                    width: 6.0,
                                    height: 6.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey, // Color del punto
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  label: Text(
                                    '3 hours ago',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color:
                                          const Color.fromARGB(255, 82, 82, 82),
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    foregroundColor: CustomColors.darkGreen,
                                    textStyle: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                    padding: EdgeInsets
                                        .zero, // Elimina el padding del botón
                                    minimumSize: Size(0,
                                        0), // Elimina el tamaño mínimo del botón
                                  ),
                                )
                              ],
                            ),
                            Transform.translate(
                              offset: Offset(0, -5),
                              child: Text(
                                'yesi@monitas.com',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Me siento realmente confundido y dolido. Nunca imaginé que mi mejor amigo, Sebastián, se enamorara de mi exnovia. Todos esos warikis compartidos entre ellos fueron a costa de acercarse a ella, y eso me duele.',
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(Icons.thumb_up,
                            size: 22.0,
                            color: const Color.fromARGB(255, 114, 114, 114)),
                        SizedBox(width: 5),
                        Text(
                          '15',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 75, 75, 75),
                          ),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.thumb_down,
                            size: 22.0,
                            color: const Color.fromARGB(255, 114, 114, 114)),
                        SizedBox(width: 5),
                        Text(
                          '3',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 75, 75, 75),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey, // Color del borde inferior
                    width: 1.0,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              'https://github.com/AplicacionesWeb-WX54/si730-WX54-Grupo1-Repository/blob/main/assets/members-profile/arigeimpleis.jpg?raw=true'),
                        ),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize
                              .min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize
                                  .min,
                              children: [
                                Text(
                                  'Liderman',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                    width:
                                        14),
                                TextButton.icon(
                                  onPressed: () {
                                    // Lógica para el botón de autor
                                  },
                                  icon: Container(
                                    width: 6.0,
                                    height: 6.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey, // Color del punto
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  label: Text(
                                    '3 hours ago',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color:
                                          const Color.fromARGB(255, 82, 82, 82),
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    foregroundColor: CustomColors.darkGreen,
                                    textStyle: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                    padding: EdgeInsets
                                        .zero,
                                    minimumSize: Size(0,
                                        0),
                                  ),
                                )
                              ],
                            ),
                            Transform.translate(
                              offset: Offset(0, -5),
                              child: Text(
                                'yesi@monitas.com',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Me siento realmente confundido y dolido. Nunca imaginé que mi mejor amigo, Sebastián, se enamorara de mi exnovia. Todos esos warikis compartidos entre ellos fueron a costa de acercarse a ella, y eso me duele.',
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(Icons.thumb_up,
                            size: 22.0,
                            color: const Color.fromARGB(255, 114, 114, 114)),
                        SizedBox(width: 5),
                        Text(
                          '15',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 75, 75, 75),
                          ),
                        ),
                        SizedBox(width: 16),
                        Icon(Icons.thumb_down,
                            size: 22.0,
                            color: const Color.fromARGB(255, 114, 114, 114)),
                        SizedBox(width: 5),
                        Text(
                          '3',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 75, 75, 75),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
