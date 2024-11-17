import 'package:aidmanager_mobile/features/auth/shared/widgets/custom_dialog_error.dart';
import 'package:aidmanager_mobile/features/auth/shared/widgets/is_empty_dialog.dart';
import 'package:aidmanager_mobile/features/posts/presentation/providers/post_provider.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/dialog/successfully_update_post_dialog.dart';
import 'package:aidmanager_mobile/shared/helpers/show_customize_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:aidmanager_mobile/config/theme/app_theme.dart';

class UpdatePostBottomModal extends StatefulWidget {
  final int postId;
  final String title;
  final String subject;
  final String description;
  final List<String> imagesList;

  const UpdatePostBottomModal({
    super.key,
    required this.title,
    required this.subject,
    required this.description,
    required this.imagesList,
    required this.postId,
  });

  @override
  State<UpdatePostBottomModal> createState() => _UpdatePostBottomModalState();
}

class _UpdatePostBottomModalState extends State<UpdatePostBottomModal> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _subjectController = TextEditingController(text: widget.subject);
    _descriptionController = TextEditingController(text: widget.description);
  }

  Future<void> onSubmitUpdatePostInformation() async {
    final title = _titleController.text.trim();
    final subject = _subjectController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || subject.isEmpty || description.isEmpty) {
      showErrorDialog(
        context,
        const IsEmptyDialog(),
      );
      return;
    }

    // cerramos el modal luego de hacer el submit
    Navigator.pop(context);

    final postProvider = context.read<PostProvider>();

    try {
      await postProvider.updatePost(widget.postId, title, subject, description, widget.imagesList);

      if (!mounted) return;

      showCustomizeDialog(context, const SuccessfullyUpdatePostDialog());
    } catch (e) {
      throw Exception('Error to update post: ${widget.postId}');
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
                  'Update Post',
                  style: TextStyle(
                    color: CustomColors.darkGreen,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    onSubmitUpdatePostInformation();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                  ),
                  child: Text(
                    'Update',
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
              controller: _titleController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _subjectController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Subject',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
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
