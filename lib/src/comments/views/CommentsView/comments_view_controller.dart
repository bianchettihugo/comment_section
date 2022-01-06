import 'dart:convert';

import 'package:comment_section/app/Input/input_controller.dart';
import 'package:comment_section/src/comments/widget/CommentField/comment_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommentsViewController {
  final commentInputController = InputController();
  late ValueNotifier<Widget> bottomWidget;

  final Future<Map<String, dynamic>> fetchComments = Future<Map<String, dynamic>>(
    () async {
      
      final response = await rootBundle.loadString('assets/data.json');
      final result = await compute((response) async {
        return await json.decode(response.toString());
      }, response);

      return result;
    },
  );

  void showCommentField(){
    bottomWidget.value = CommentField(this);
    Future.delayed(const Duration(milliseconds: 400), (){
      commentInputController.focusNode.requestFocus();
    });
  }
  
}