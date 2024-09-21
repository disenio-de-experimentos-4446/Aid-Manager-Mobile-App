import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo(this.title, this.caption, this.imageUrl);
}

final slides = <SlideInfo>[
  SlideInfo(
      'Welcome to AidManager',
      'Manage bank accounts anytime and transfer money anywhere in the world',
      'assets/images/image-slider-one.png'),
  SlideInfo(
      'Secure Money',
      'Protect your money and credit cards with our security technology',
      'assets/images/image-slider-one.png'),
  SlideInfo(
      'Manage Finance',
      'Get insights from us that faster more understanding about your finances',
      'assets/images/image-slider-one.png')
];

class WaveClipper extends CustomClipper<Path> {
  final double controlPointHeight1;
  final double controlPointHeight2;
  final double endPointHeight1;
  final double endPointHeight2;

  WaveClipper({
    required this.controlPointHeight1,
    required this.controlPointHeight2,
    required this.endPointHeight1,
    required this.endPointHeight2,
  });

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - endPointHeight1);
    var firstControlPoint =
        Offset(size.width / 4, size.height - controlPointHeight1);
    var firstEndPoint = Offset(size.width / 2, size.height - endPointHeight1);
    var secondControlPoint =
        Offset(size.width * 3 / 4, size.height - controlPointHeight2);
    var secondEndPoint = Offset(size.width, size.height - endPointHeight2);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - endPointHeight2);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant WaveClipper oldClipper) {
    return oldClipper.controlPointHeight1 != controlPointHeight1 ||
        oldClipper.controlPointHeight2 != controlPointHeight2 ||
        oldClipper.endPointHeight1 != endPointHeight1 ||
        oldClipper.endPointHeight2 != endPointHeight2;
  }
}

class TutorialScreen extends StatefulWidget {
  static const String name = "tutorial_screen";

  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController pageController = PageController();
  bool endReached = false;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColors.lightGrey,
      body: Column(
        children: [
          ClipPath(
            clipper: WaveClipper(
              controlPointHeight1: 0,
              controlPointHeight2: 60,
              endPointHeight1: 30,
              endPointHeight2: 20,
            ),
            child: Container(
              height: 550,
              color: const Color.fromARGB(255, 191, 250, 208),
              child: Center(
                child: Image.asset(
                  'assets/images/image-slider-one.png',
                  fit: BoxFit.cover,
                  width: 440,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: deviceWidth * 0.85,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 25, // Ancho mayor para crear un óvalo
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.green, // Color verde
                            shape: BoxShape
                                .rectangle, // Cambia a rectángulo para permitir el óvalo
                            borderRadius: BorderRadius.all(Radius.circular(
                                10)), // Bordes redondeados para el óvalo
                          ),
                        ),
                        const SizedBox(width: 10), // Espacio entre los círculos
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 187, 187, 187),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10), // Espacio entre los círculos
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 187, 187, 187),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    const Text(
                      'Secure Money',
                      style: TextStyle(
                          fontSize: 34.0,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Manage projects anytime and transfer money anywhere in the world',
                      style: TextStyle(
                          color: Color.fromARGB(179, 0, 0, 0),
                          fontSize: 20.0,
                          letterSpacing: 0.8,
                          height: 1.8,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: Container(color: Colors.transparent),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // process
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  CustomColors.lightTeal, // Color de fondo
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              minimumSize: const Size(double.infinity, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text(
                              'Contact us',
                              style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30.0),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // process
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                  255, 86, 122, 106), // Color de fondo
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              minimumSize: const Size(double.infinity, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35.0),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
