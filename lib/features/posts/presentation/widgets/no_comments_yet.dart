import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class NoCommentsYet extends StatelessWidget {
  final VoidCallback onAddComment;

  const NoCommentsYet({
    super.key,
    required this.onAddComment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          Icon(
            Icons.comment,
            size: 48.0,
            color: Colors.grey,
          ),
          SizedBox(height: 8),
          Text(
            'No comments yet',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: onAddComment,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.green,
              backgroundColor: CustomColors.lightGreen,
            ),
            child: Text(
              'Be the first to comment',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
