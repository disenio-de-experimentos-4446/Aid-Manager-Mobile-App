import 'package:aidmanager_mobile/features/projects/presentation/widgets/project/dialog/successfully_project_submit_favorite_dialog.dart';
import 'package:flutter/material.dart';

class PrincipalProjectCard extends StatefulWidget {
  final int projectId;
  final String name;
  final String description;
  final List<String> imagesUrl;
  final double rating;
  final List<dynamic> userList;
  final bool isFavorite;
  final VoidCallback onPressedCard;
  final VoidCallback onSubmitFavorite;

  const PrincipalProjectCard({
    super.key,
    required this.onPressedCard,
    required this.name,
    required this.description,
    required this.imagesUrl,
    required this.userList,
    required this.onSubmitFavorite,
    required this.projectId,
    required this.isFavorite,
    required this.rating,
  });

  @override
  State<PrincipalProjectCard> createState() => _PrincipalProjectCardState();
}

class _PrincipalProjectCardState extends State<PrincipalProjectCard> {
  // esto es para simular el efecto de pintado del corazon solo es superficial su efecto
  bool clickedFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressedCard,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Card(
          color: const Color.fromARGB(255, 241, 241, 241),
          elevation: 1.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    widget.imagesUrl[0],
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
                  Positioned(
                    top: 15.0,
                    right: 15.0,
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
                          size: 30.0,
                        ),
                        onPressed: clickedFavorite || widget.isFavorite
                            ? null
                            : () {
                                setState(() {
                                  clickedFavorite = true;
                                });
                                widget.onSubmitFavorite();
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
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 16.0,
                        height: 1.65,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.group,
                              color: Colors.grey,
                              size: 28.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '${widget.userList.length} miembros',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                              width: 1.0,
                            ),
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 3.0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                color: Colors.yellow[700],
                                size: 30,
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                widget.rating == 0 || widget.rating == 0.0
                                    ? 'N/A'
                                    : widget.rating.toString(),
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.yellow[800],
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
