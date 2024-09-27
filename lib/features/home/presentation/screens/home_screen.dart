import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/home/presentation/widgets/metric_card.dart';
import 'package:aidmanager_mobile/features/home/presentation/widgets/project_card.dart';
import 'package:flutter/material.dart';

class MetricItem {
  final IconData icon;
  final String title;
  final String caption;

  MetricItem({required this.icon, required this.caption, required this.title});
}

final List<MetricItem> metricsList = [
  MetricItem(
      icon: Icons.monetization_on, caption: '\$65.0', title: 'Total Earning'),
  MetricItem(
      icon: Icons.addchart_sharp, caption: '120', title: 'Total Projects'),
  MetricItem(icon: Icons.people, caption: '350', title: 'Total Customers'),
  MetricItem(icon: Icons.star, caption: '4.8', title: 'Average Rating'),
];

class HomeScreen extends StatelessWidget {
  static const String name = "home_screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const HomeContent(),
        );
      },
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.lightGrey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _BannerHome(),
              const SizedBox(height: 25),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Text(
                        ' Recent members',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'See All',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: CustomColors.darkGreen,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                              width: 5.0),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: CustomColors.darkGreen,
                            size: 24.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _MemberShape('assets/images/hotman-placeholder.jpg'),
                        _MemberShape('assets/images/hotman-placeholder.jpg'),
                        _MemberShape('assets/images/hotman-placeholder.jpg'),
                        _MemberShape('assets/images/hotman-placeholder.jpg'),
                        _MemberShape('assets/images/hotman-placeholder.jpg'),
                        _MemberShape('assets/images/hotman-placeholder.jpg'),
                        _MemberShape('assets/images/hotman-placeholder.jpg'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Projects',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'See All',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: CustomColors.darkGreen,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                              width: 5.0), // Espacio entre el texto y el icono
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: CustomColors.darkGreen,
                            size: 24.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: 240,
                    child: CarouselView(
                        itemExtent: MediaQuery.sizeOf(context).width - 96,
                        padding: const EdgeInsets.only(right: 10),
                        itemSnapping: true,
                        elevation: 4.0,
                        children: List.generate(
                            10, (int index) => const ProjectCard())),
                  )
                ],
              ),
              const SizedBox(height: 35),
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Organization metrics',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'See All',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: CustomColors.darkGreen,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                              width: 5.0),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: CustomColors.darkGreen,
                            size: 24.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 340,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final metric = metricsList[index];
                        return MetricCard(
                          icon: metric.icon,
                          title: metric.title,
                          caption: metric.caption,
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MemberShape extends StatelessWidget {
  final String imagePath;

  const _MemberShape(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey, // Borde gris
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
          const SizedBox(height: 10.0),
          const Text(
            'Hotman',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerHome extends StatelessWidget {
  const _BannerHome();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250.0,
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 200, 238, 199),
            Color.fromARGB(255, 192, 236, 210),
            Color.fromARGB(255, 125, 211, 125),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Experience the thrill of Risk-free trading',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        height: 1.65),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Acción del botón
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 59, 153, 62),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        SizedBox(width: 8.0),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/home-image.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
