import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;
  final WaveClipper waveClipper;

  SlideInfo(this.title, this.caption, this.imageUrl, [WaveClipper? waveClipper])
      : waveClipper = waveClipper ??
            WaveClipper(
                controlPointHeight1: 0,
                controlPointHeight2: 0,
                endPointHeight1: 0,
                endPointHeight2: 0);
}

// no mover los puntos Dx, es para crear un b_radius en forma de ola usando ClipPath
final slides = <SlideInfo>[
  SlideInfo(
      'Welcome to AidManager',
      'Manage bank accounts anytime and transfer money anywhere in the world',
      'assets/images/image-slider-one.png',
      WaveClipper(
          controlPointHeight1: 0,
          controlPointHeight2: 60,
          endPointHeight1: 30,
          endPointHeight2: 25)),
  SlideInfo(
      'Manage Finance',
      'Manage your project finances with our advanced management tools.',
      'assets/images/image-slider-two.png',
      WaveClipper(
          controlPointHeight1: 50,
          controlPointHeight2: 0,
          endPointHeight1: 25,
          endPointHeight2: 30)),
  SlideInfo(
      'Collaborate Team',
      'Collaborate with your team and gain deeper insights to improve projects.',
      'assets/images/image-slider-three.png',
      WaveClipper(
          controlPointHeight1: 0,
          controlPointHeight2: 60,
          endPointHeight1: 30,
          endPointHeight2: 20))
];

// es mejor que cargar una imagen de fondo xD
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
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      final page = pageController.page ?? 0;
      setState(() {
        currentPage = page.round();
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColors.lightGrey,
      body: PageView.builder(
        controller: pageController,
        itemCount: slides.length,
        itemBuilder: (context, index) {
          final slide = slides[index];
          return _Slide(
            title: slide.title,
            caption: slide.caption,
            bannerImage: slide.imageUrl,
            deviceWidth: deviceWidth,
            currentPage: currentPage,
            waveClipper: slide.waveClipper,
          );
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String title;
  final String caption;
  final String bannerImage;
  final double deviceWidth;
  final int currentPage;
  final WaveClipper waveClipper;

  const _Slide({
    required this.deviceWidth,
    required this.title,
    required this.caption,
    required this.bannerImage,
    required this.waveClipper, required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipPath(
          clipper: waveClipper,
          child: Container(
            height: 550,
            color: const Color.fromARGB(255, 191, 250, 208),
            child: Center(
              child: Image.asset(
                bannerImage,
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
                    children: List.generate(slides.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        width: index == currentPage ? 25 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: index == currentPage
                              ? Colors.green
                              : const Color.fromARGB(255, 187, 187, 187),
                          shape: index == currentPage
                              ? BoxShape.rectangle
                              : BoxShape.circle,
                          borderRadius: index == currentPage
                              ? BorderRadius.circular(10)
                              : null,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 34.0,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    caption,
                    style: const TextStyle(
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
                            context.go('/home');
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
    );
  }
}
