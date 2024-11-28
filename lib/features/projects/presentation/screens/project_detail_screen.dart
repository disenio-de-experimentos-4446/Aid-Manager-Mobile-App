import 'dart:ui';
import 'package:aidmanager_mobile/config/helpers/date_format.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:aidmanager_mobile/features/projects/presentation/providers/project_provider.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/project/dialog/rating_project_dialog.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/project/dialog/successfully_project_submit_favorite_dialog.dart';
import 'package:aidmanager_mobile/features/projects/presentation/widgets/project/dialog/successfully_rating_project_dialog.dart';
import 'package:aidmanager_mobile/shared/helpers/show_customize_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailScreen extends StatefulWidget {
  static const String name = "project_detail_screen";
  final String projectId;
  final bool isFavorite;

  const ProjectDetailScreen({
    super.key,
    required this.projectId,
    required this.isFavorite,
  });

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  // esto es para simular el efecto de pintado del corazon solo es superficial su efecto
  bool clickedFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadProjectDetail();
  }

  Future<void> _loadProjectDetail() async {
    final projectId = int.parse(widget.projectId);
    await context.read<ProjectProvider>().loadProjectDetail(projectId);
  }

  Future<void> onSubmitFavorite(int projectId) async {
    final projectProvider = context.read<ProjectProvider>();

    projectProvider.saveProjectAsFavorite(projectId);
  }

  Future<void> onUpdateRatingProject(double rating) async {
    final projectProvider = context.read<ProjectProvider>();

    try {
      await projectProvider.updateProjectRating(
          int.parse(widget.projectId), rating);

      if (!mounted) return;

      showCustomizeDialog(context, SuccessfullyRatingProjectDialog());
    } catch (e) {
      throw Exception('Error to update rating from project $e');
    }
  }

  Future<void> _launchURLLandingPage() async {
    const url = 'https://landing-page-aid-manager-37nb.vercel.app/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $url'),
        ),
      );
    }
  }

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'yesi@aidmanager.com',
      queryParameters: {'subject': 'Information about AidManager'},
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not send email to aidmanager@example.com'),
        ),
      );
    }
  }

  double _calculateCompletionPercentage(List<dynamic>? userList) {
    if (userList == null || userList.isEmpty) {
      return 0.0;
    }
    final completedTasks =
        userList.where((user) => user['completed'] == true).length;
    final totalTasks = userList.length;
    return (completedTasks / totalTasks) * 100;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black.withOpacity(0.5),
    ));

    final projectProvider = context.watch<ProjectProvider>();

    final project = projectProvider.projectDetail;
    final detailLoading = projectProvider.detailLoading;

    final now = DateTime.now();
    final difference = project?.projectDate.difference(now).inDays ?? 0;

    final completionPercentage =
        _calculateCompletionPercentage(project?.userList);

    return SafeArea(
      child: Scaffold(
        body: detailLoading
            ? Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      strokeWidth: 8,
                      color: CustomColors
                          .darkGreen, // Puedes cambiar el color aquí
                    ),
                  ),
                ),
              )
            : Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 400,
                    child: Image.network(
                      project!.imageUrl[0],
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/placeholder-image.webp',
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: GestureDetector(
                          onTap: () {
                            context.go('/projects');
                          },
                          child: Container(
                            color: Colors.black.withOpacity(0.3),
                            padding: EdgeInsets.all(10.0),
                            child: Center(
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
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          clickedFavorite || widget.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                          color: clickedFavorite || widget.isFavorite
                              ? Colors.red
                              : Colors.black87,
                          size: 32.0,
                        ),
                        onPressed: clickedFavorite || widget.isFavorite
                            ? null
                            : () {
                                setState(() {
                                  clickedFavorite = true;
                                });
                                onSubmitFavorite(project.id!);
                                if (!mounted) return;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SuccessfullyProjectSubmitFavoriteDialog();
                                  },
                                );
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
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 25),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      project.name ?? 'Project PlaceHolder',
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () async {
                                        final selectedRating =
                                            await showDialog<double>(
                                          context: context,
                                          builder: (context) =>
                                              RatingProjectDialog(
                                            initialRating: project.rating!,
                                          ),
                                        );

                                        if (selectedRating != null) {
                                          onUpdateRatingProject(selectedRating);
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Ink(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow[800],
                                              size: 28.0,
                                            ),
                                            SizedBox(width: 8.0),
                                            Text(
                                              project.rating == 0 ||
                                                      project.rating == 0.0
                                                  ? 'N/A'
                                                  : project.rating.toString(),
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.65,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.black.withOpacity(0.6),
                                      size: 18.0,
                                    ),
                                    SizedBox(width: 5.0),
                                    Text(
                                      project.projectLocation,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        letterSpacing: 0.35,
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
                                      size: 16.0,
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      project.projectDate != null
                                          ? DateFormat('yyyy-MM-dd')
                                              .format(project.projectDate)
                                          : 'No date',
                                      style: TextStyle(
                                        fontSize: 15.0,
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
                                      size: 16.0,
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      project.projectTime != null
                                          ? formatTimeOfDay(project.projectTime)
                                          : 'No Time',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      SizedBox(width: 10.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Auspiced By',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            'AidManager',
                                            style: TextStyle(
                                              fontSize: 18.0,
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
                                          color: Colors.blue.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: Colors.blue.withOpacity(
                                                0.5), // Color del borde
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
                                            _launchURLLandingPage();
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 12.0),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: Colors.red.withOpacity(0.5),
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
                                            _sendEmail();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'About Project',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          context.go(
                                              '/projects/${widget.projectId}/dashboard?name=${Uri.encodeComponent(project.name)}');
                                        },
                                        child: Text(
                                          'See Metrics',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: CustomColors.darkGreen,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 16.0,
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
                                project.description ?? 'No description',
                                style: TextStyle(fontSize: 16.0, height: 1.65),
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
                                      color: const Color.fromARGB(
                                        255,
                                        187,
                                        185,
                                        185,
                                      ).withOpacity(0.5),
                                      spreadRadius: 1.5,
                                      blurRadius: 2,
                                      offset: Offset(0, 1),
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
                                                  size: 24.0,
                                                ),
                                                SizedBox(width: 12.0),
                                                Text(
                                                  project.projectLocation ??
                                                      'No location',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                  ),
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
                                        color: const Color.fromARGB(
                                            255, 199, 195, 195),
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
                                              size: 24.0,
                                            ),
                                            SizedBox(width: 12.0),
                                            Text(
                                              '${project.audit != null ? DateFormat('MMM d, yyyy').format(project.audit!) : 'No date'} - To: ${DateFormat('MMM d, yyyy').format(project.projectDate)}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: const Color.fromARGB(
                                                    200, 0, 0, 0),
                                              ),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: NumberFormat("0")
                                                .format(difference)
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors
                                                  .green, // Color del número
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' days left', // Texto
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
                                            text:
                                                (project.userList?.length ?? 0)
                                                    .toString(),
                                            style: TextStyle(
                                              color: Colors
                                                  .green, // Color del número
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
                                            text:
                                                '${completionPercentage.toStringAsFixed(0) ?? 0}%',
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' activities', // Texto
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      context.go(
                                          '/projects/${widget.projectId}/tasks?name=${Uri.encodeComponent(project.name)}');
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
                              SizedBox(height: 12),
                              SizedBox(
                                height: 75,
                                child: project.userList?.isEmpty ?? true
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            project.userList?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          final collaborator =
                                              project.userList![index]
                                                  as Map<String, dynamic>;
                                          return _CollaboratorShape(
                                            collaborator['profileImg'],
                                          );
                                        },
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
                              _ProjectHighlights(
                                createdAt: project.audit!,
                                projectDate: project.projectDate,
                                projectTime: project.projectTime,
                              ),
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
  final DateTime createdAt;
  final DateTime projectDate;
  final TimeOfDay projectTime;

  const _ProjectHighlights({
    required this.projectDate,
    required this.projectTime,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final DateFormat timeFormat = DateFormat('HH:mm');

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
                    'Started Date:',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Finish Date:',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Started hour:',
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
                    dateFormat.format(createdAt),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    dateFormat.format(projectDate),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    timeFormat.format(DateTime(
                        projectDate.year,
                        projectDate.month,
                        projectDate.day,
                        projectTime.hour,
                        projectTime.minute)),
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
      padding: EdgeInsets.only(right: 20.0),
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
              Colors.black.withOpacity(0.10),
              BlendMode.darken,
            ),
            child: Image.network(
              imagePath,
              width: 75.0,
              height: 75.0,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/profile-placeholder.jpg',
                  width: 75.0,
                  height: 75.0,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
