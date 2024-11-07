import 'package:aidmanager_mobile/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class NewPostBottomModal extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController subjectController;
  final TextEditingController descriptionController;
  final VoidCallback onSubmitPost;

  const NewPostBottomModal({
    super.key,
    required this.titleController,
    required this.subjectController,
    required this.descriptionController,
    required this.onSubmitPost,
  });

  @override
  State<NewPostBottomModal> createState() => _NewPostBottomModalState();
}

class _NewPostBottomModalState extends State<NewPostBottomModal> {

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
                  'New Post',
                  style: TextStyle(
                    color: CustomColors.darkGreen,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onSubmitPost();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700], // Color de fondo rojizo
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
              controller: widget.titleController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: widget.subjectController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Subject',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: widget.descriptionController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
