import 'package:comment_section/app/application.dart';
import 'package:flutter/material.dart';

class CommentsListError extends StatelessWidget {
  final Object? error;
  const CommentsListError(this.error, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 60.w,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Text('Error: $error', textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }
}