import 'package:comment_section/global/Theme/theme.dart';
import 'package:comment_section/global/application.dart';
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
        title: 'Comments Section',
        theme: AppTheme.theme,
        home: Container(),
      ),
    );
  }
}