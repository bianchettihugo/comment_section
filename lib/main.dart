import 'package:comment_section/app/Theme/theme.dart';
import 'package:comment_section/app/application.dart';
import 'package:comment_section/src/comments/views/CommentsView/comments_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ApplicationWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Comments Section',
        theme: AppTheme.theme,
        home: CommentsView(),
      ),
    );
  }
}