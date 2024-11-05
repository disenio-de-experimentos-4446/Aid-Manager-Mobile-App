import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final int postId;
  final String username;
  final String title;
  final String description;
  final String email;
  final String profileImg;
  final List<String> images;
  final int rating;
  final int numComments;
  final DateTime postTime;

  const PostCard({
    super.key,
    required this.username,
    required this.email,
    required this.profileImg,
    required this.images,
    required this.rating,
    required this.numComments,
    required this.postTime,
    required this.postId,
    required this.description,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 25.0, right: 20.0, left: 20.0, bottom: 30.0),
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
                      ),
                      child: ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/profile-placeholder.jpg',
                          image: profileImg,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/profile-placeholder.jpg',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          email,
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
                        context.go('/posts/$postId');
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
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    height: 1.65,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  description,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                    height: 1.65,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
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
                      Text(rating.toString(), style: TextStyle(fontSize: 16.0)),
                      SizedBox(width: 16.0),
                      Icon(
                        Icons.comment,
                        color: Colors.grey,
                        size: 26.0,
                      ),
                      SizedBox(width: 8.0),
                      Text(numComments.toString(),
                          style: TextStyle(fontSize: 16.0)),
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
                        DateFormat('dd/MM/yyyy').format(postTime),
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
