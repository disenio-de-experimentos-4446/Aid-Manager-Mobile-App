import 'package:aidmanager_mobile/features/posts/presentation/widgets/dialog/error_create_comment_dialog.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/dialog/error_create_post_dialog.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/dialog/error_fetch_posts_dialog.dart';
import 'package:aidmanager_mobile/features/posts/presentation/widgets/dialog/error_post_rating_dialog.dart';
import 'package:aidmanager_mobile/features/posts/shared/exceptions/posts_exception.dart';
import 'package:flutter/material.dart';

// Función para devolver el diálogo adecuado basado en la excepción capturada
Widget getPostErrorDialog(BuildContext context, Exception e) {
  if (e is PostCreationException) {
    return const ErrorCreatePostDialog();
  } else if (e is InitialPostsLoadException) {
    return const ErrorFetchPostsDialog();
  } else if (e is NewPostCreationException) {
    return const ErrorCreatePostDialog();
  } else if (e is PostRatingException) {
    return const ErrorPostRatingDialog();
  } else if (e is PostCommentException) {
    return const ErrorCreateCommentDialog();
  } else {
    return AlertDialog(
      title: const Text('Error'),
      content: const Text('An unknown error occurred D:'),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

// Función para mostrar el diálogo de error
void showErrorDialog(BuildContext context, Widget dialog) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
}
