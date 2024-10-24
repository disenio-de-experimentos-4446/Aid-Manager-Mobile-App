import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey, // Color del borde
            width: 1.0, // Ancho del borde
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0, right: 20.0, left: 20.0, bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/hotman-placeholder.jpg'), // Usa AssetImage en lugar de Image.asset
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nombre del Usuario',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.5),
                        Text(
                          'correo@ejemplo.com',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.go('/posts/1');
                      },
                      child: Icon(Icons.open_in_new_rounded, size: 32),
                    ),
                    SizedBox(width: 12.0),
                    GestureDetector(
                      onTap: () {
                        // Acción del botón de editar
                      },
                      child: Icon(Icons.more_vert_sharp, size: 34),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Text(
              'lorem ipsum sexo lorem ipsum sexo lorem ipsum sexo lorem ipsum sexo lorem ipsum sexo lorem ipsum sexo',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                height: 1.65,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 225,
              child: CarouselView(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      20.0), // Ajusta el radio del borde según sea necesario
                ),
                itemExtent: MediaQuery.sizeOf(context).width - 96,
                padding: const EdgeInsets.only(right: 10),
                itemSnapping: true,
                elevation: 4.0,
                children: List.generate(
                  10,
                  (int index) => Image.network(
                    'https://img.freepik.com/premium-photo/woman-with-backpack-stands-mountain-top-looking-beautiful-sunset_188544-54443.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 26.0,
                      ),
                      SizedBox(width: 8.0),
                      Text('123', style: TextStyle(fontSize: 16.0)),
                      SizedBox(width: 16.0),
                      Icon(
                        Icons.comment,
                        color: Colors.grey,
                        size: 26.0,
                      ),
                      SizedBox(width: 8.0),
                      Text('222', style: TextStyle(fontSize: 16.0)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                        size: 24.0,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '12/10/2023',
                        style: TextStyle(fontSize: 16.0, letterSpacing: 1.05),
                      ), // Fecha
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
