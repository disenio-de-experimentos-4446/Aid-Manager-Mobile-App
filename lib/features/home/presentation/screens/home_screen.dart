import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/home/presentation/providers/home_provider.dart';
import 'package:aidmanager_mobile/features/home/presentation/widgets/members_carousel.dart';
import 'package:aidmanager_mobile/features/home/presentation/widgets/metric_card.dart';
import 'package:aidmanager_mobile/features/home/presentation/widgets/projects_carousel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MetricItem {
  final IconData icon;
  final String title;
  final String caption;

  MetricItem({required this.icon, required this.caption, required this.title});
}

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

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
    _loadInitialInformation();
  }

  Future<void> _loadInitialInformation() async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    await homeProvider.loadInitialInformation();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final teamMembers =
        homeProvider.users.where((user) => user.role == 'TeamMember').toList();

    final doneTasksCount =
        homeProvider.tasks.where((task) => task.state == 'Done').length;

    return Scaffold(
      backgroundColor: CustomColors.lightGrey,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _BannerHome(),
                  const SizedBox(height: 25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent members',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.go('/social');
                            },
                            child: Row(
                              children: [
                                Text(
                                  'See All',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: CustomColors.darkGreen,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 5.0),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: CustomColors.darkGreen,
                                  size: 22.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      teamMembers.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.group,
                                      size: 40, color: Colors.grey),
                                  SizedBox(height: 8),
                                  Text(
                                    'No collaborators',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : MembersCarousel(members: teamMembers),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular Projects',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.go('/projects');
                            },
                            child: Row(
                              children: [
                                Text(
                                  'See All',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: CustomColors.darkGreen,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                    width:
                                        5.0), // Espacio entre el texto y el icono
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: CustomColors.darkGreen,
                                  size: 22.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      homeProvider.projects.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.folder_open,
                                      size: 40, color: Colors.grey),
                                  SizedBox(height: 8),
                                  Text(
                                    'No projects available',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ProjectsCarousel(projects: homeProvider.projects),
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
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'See All',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: CustomColors.darkGreen,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 5.0),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: CustomColors.darkGreen,
                                size: 22.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap:
                            true, // Permite que el GridView se ajuste a su contenido
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 15.0,
                          childAspectRatio: 1,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return IntrinsicHeight(
                                child: MetricCard(
                                  icon: Icons.grading_outlined,
                                  title: 'Tasks Completed',
                                  caption: doneTasksCount.toString(),
                                ),
                              );
                            case 1:
                              return IntrinsicHeight(
                                child: MetricCard(
                                  icon: Icons.addchart_sharp,
                                  title: 'Total Projects',
                                  caption:
                                      homeProvider.projects.length.toString(),
                                ),
                              );
                            case 2:
                              return IntrinsicHeight(
                                child: MetricCard(
                                  icon: Icons.people,
                                  title: 'Total Members',
                                  caption: homeProvider.users.length.toString(),
                                ),
                              );
                            case 3:
                              return IntrinsicHeight(
                                child: MetricCard(
                                  icon: Icons.star_rounded,
                                  title: 'Average Rating',
                                  caption: '4.5',
                                ),
                              );
                            default:
                              return Container();
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          if (homeProvider.initialLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                    color:
                        CustomColors.darkGreen, // Puedes cambiar el color aquí
                  ),
                ),
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
      height: 260.0,
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
            offset: const Offset(0, 3),
          ),
        ],
        image: const DecorationImage(
          image: AssetImage('assets/images/home-banner.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Experience the thrill of Risk-free trading',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              letterSpacing: 0.65,
                              fontWeight: FontWeight.bold,
                              height: 1.65),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.go('/projects');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 59, 153, 62),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 0),
                  Expanded(
                    child: Center(
                      child: Container(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
