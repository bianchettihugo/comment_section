import 'package:comment_section/app/Dependency/dependency.dart';
import 'package:comment_section/app/application.dart';
import 'package:comment_section/src/comments/models/comment.dart';
import 'package:comment_section/src/comments/views/CommentsView/comments_view_controller.dart';
import 'package:comment_section/src/comments/widget/CommentCard/comment_card.dart';
import 'package:flutter/material.dart';

class CommentsList extends StatelessWidget {
  final CommentsViewController controller;
  final Map<String, dynamic> data;
  CommentsList(this.data, { Key? key })
  : controller = Dependency.get<CommentsViewController>(), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 25.w
      ),
      child: ValueListenableBuilder<Map<String, dynamic>>(
        valueListenable: controller.comments!,
        builder:(context, comments, child) => ListView.builder(
          padding: EdgeInsets.only(bottom: 90.h),
          itemCount: comments['comments'].length,
          itemBuilder: (context, index){
            final comment = Comment.fromJson(comments['comments'][index]);
            return CommentCard(
              commentIndex: index.toString(),
              comment: comment,
              onScoreChange: (score){
                comments['comments'][index]['score'] = score;
              },
            );
          }
        ),
      )
    );
  }
}