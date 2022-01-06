import 'package:comment_section/app/application.dart';
import 'package:comment_section/src/comments/models/comment.dart';
import 'package:comment_section/src/comments/views/CommentsView/comments_view_controller.dart';
import 'package:comment_section/src/comments/widget/CommentCard/comment_card.dart';
import 'package:flutter/material.dart';

class CommentsList extends StatelessWidget {
  final CommentsViewController controller;
  final Map<String, dynamic> data;
  const CommentsList(this.controller, this.data, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 25.w
      ),
      child: ListView.builder(
        itemCount: data['comments'].length,
        itemBuilder: (context, index){
          final comment = Comment.fromJson(data['comments'][index]);
          return CommentCard(comment: comment);
        }
      )
    );
  }
}