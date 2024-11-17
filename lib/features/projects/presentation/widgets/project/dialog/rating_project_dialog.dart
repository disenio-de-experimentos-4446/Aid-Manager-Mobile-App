import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingProjectDialog extends StatefulWidget {
  final double initialRating;

  const RatingProjectDialog({super.key, required this.initialRating});

  @override
  State<RatingProjectDialog> createState() => _RatingProjectDialogState();
}

class _RatingProjectDialogState extends State<RatingProjectDialog> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.folder,
            color: Colors.black87,
            size: 64.0,
          ),
          SizedBox(height: 18.0),
          Text(
            'Rate this Project',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select the star rating to rate the project. This action will be visible to all team members.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, height: 1.65),
          ),
          SizedBox(height: 18.0),
          RatingBar.builder(
            initialRating: _currentRating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _currentRating = rating;
              });
            },
          ),
          SizedBox(height: 5.0),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[400],
          ),
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
        SizedBox(width: 2.0),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_currentRating);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[400],
          ),
          child: Text(
            'Submit',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
