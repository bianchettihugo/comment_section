import 'dart:convert';

import 'package:comment_section/app/Input/input_controller.dart';
import 'package:comment_section/src/comments/models/comment.dart';
import 'package:comment_section/src/comments/widget/CommentAlertDialog/comment_alert_dialog.dart';
import 'package:comment_section/src/comments/widget/CommentField/comment_field.dart';
import 'package:comment_section/src/users/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommentsViewController extends ChangeNotifier {
  ValueNotifier<Map<String, dynamic>>? comments;
  final commentInputController = InputController();
  final commentWriteInputController = InputController();
  late ValueNotifier<Widget> bottomWidget;
  final ScrollController scrollController = ScrollController();

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
    Future.delayed(const Duration(milliseconds: 200), (){
      commentInputController.focusNode.requestFocus();
    });
  }

  void sendComment(){
    if(commentInputController.textController.text.trim().isNotEmpty){
      final today = DateTime.now();
      final newComment = Comment(
        id: comments!.value['comments'].length, 
        content: commentInputController.textController.text, 
        createdAt: '${today.day.toString().padLeft(2,'0')}/${today.month.toString().padLeft(2,'0')}/${today.year.toString()}', 
        user: User.fromJson(comments!.value['currentUser']),
      );

      comments?.value['comments'] = List.from(comments?.value['comments'])..add(newComment.toJson());
      comments?.notifyListeners();
      commentInputController.textController.text = '';
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 400), curve: Curves.linear);
    }
  }

  void deleteComment(String id) async {
    int parentIndex = 0;
    int index = -1;
    if(id.contains(':')){
      final tokens = id.split(':');
      parentIndex = int.parse(tokens[0]);
      index = int.parse(tokens[1]);
      (comments?.value['comments'][parentIndex]['replies'] as List).removeAt(index);
    }else {
      parentIndex = int.parse(id);
      (comments?.value['comments'] as List).removeAt(parentIndex);
    }

    comments?.notifyListeners();
  }

  void updateComment(String id) async {
    if(commentWriteInputController.textController.text.trim().isEmpty) return;
    int parentIndex = 0;
    int index = -1;
    if(id.contains(':')){
      final tokens = id.split(':');
      parentIndex = int.parse(tokens[0]);
      index = int.parse(tokens[1]);
      (comments?.value['comments'][parentIndex]['replies'] as List)[index]['content']
      = commentWriteInputController.textController.text;
    }else {
      parentIndex = int.parse(id);
      (comments?.value['comments'] as List)[parentIndex]['content']
      = commentWriteInputController.textController.text;
    }

    comments?.notifyListeners();
  }

  void replyComment(String replyingTo, String id){
    if(commentWriteInputController.textController.text.trim().isNotEmpty){
      final today = DateTime.now();
      final newComment = Comment(
        id: comments!.value['comments'].length, 
        content: commentWriteInputController.textController.text, 
        createdAt: '${today.day.toString().padLeft(2,'0')}/${today.month.toString().padLeft(2,'0')}/${today.year.toString()}',
        replyingTo: replyingTo,
        user: User.fromJson(comments!.value['currentUser']),
      );

      int parentIndex = 0;
      if(id.contains(':')){
        final tokens = id.split(':');
        parentIndex = int.parse(tokens[0]);
        (comments?.value['comments'] as List)[parentIndex]['replies'].add(newComment.toJson());
      }else {
        parentIndex = int.parse(id);
        (comments?.value['comments'] as List)[parentIndex]['replies'].add(newComment.toJson());
      }
      comments?.notifyListeners();
      commentWriteInputController.textController.text = '';
    }
  }


  Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
    bool result = false;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CommentAlertDialog(
          onAccept: ()=>result = true,
          onRefuse: ()=>result = false,
        );
      },
    );

    return result;
  }
  
}