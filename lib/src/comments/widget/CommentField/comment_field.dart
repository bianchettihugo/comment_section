import 'package:comment_section/app/Button/button.dart';
import 'package:comment_section/app/Input/input.dart';
import 'package:comment_section/app/application.dart';
import 'package:comment_section/src/comments/views/CommentsView/comments_view_controller.dart';
import 'package:flutter/material.dart';

class CommentField extends StatelessWidget {
  final CommentsViewController controller;

  const CommentField(this.controller, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 20.w
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: [
          Input('', 
            hint: 'Add a comment', 
            maxLines: 3,
            controller: controller.commentInputController,
            shouldDispose: false,
            onEditingComplete: ()=> controller.bottomWidget.value = FloatingActionButton(
              child: const Icon(Icons.comment),
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: controller.showCommentField
            ),
          ),
          SizedBox(height: 25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(controller.comments?.value['currentUser']['image']['png']),
              ),
              const Expanded(child: SizedBox(), flex: 2),
              Expanded(child: Button(text: 'SEND', onTap: (){
                controller.sendComment();
                controller.bottomWidget.value = FloatingActionButton(
                  child: const Icon(Icons.comment),
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: controller.showCommentField
                );
              }))
            ],
          )
        ],
      ),
    );
  }
}