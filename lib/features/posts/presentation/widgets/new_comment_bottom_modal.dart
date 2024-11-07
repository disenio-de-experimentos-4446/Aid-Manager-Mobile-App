import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class NewCommentBottomModal extends StatefulWidget {
  final TextEditingController commentController;
  final VoidCallback onSubmitComment;

  const NewCommentBottomModal({
    super.key,
    required this.commentController, required this.onSubmitComment,
  });

  @override
  State<NewCommentBottomModal> createState() => _NewCommentBottomModalState();
}

class _NewCommentBottomModalState extends State<NewCommentBottomModal> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New Comment',
                  style: TextStyle(
                    color: CustomColors.darkGreen,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onSubmitComment();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: widget.commentController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Content',
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
