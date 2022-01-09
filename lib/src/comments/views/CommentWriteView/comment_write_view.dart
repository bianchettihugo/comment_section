import 'package:comment_section/app/Button/button.dart';
import 'package:comment_section/app/Dependency/dependency.dart';
import 'package:comment_section/app/Input/input.dart';
import 'package:comment_section/app/application.dart';
import 'package:comment_section/src/comments/models/comment.dart';
import 'package:comment_section/src/comments/views/CommentsView/comments_view_controller.dart';
import 'package:comment_section/src/comments/widget/CommentCard/comment_card.dart';
import 'package:flutter/material.dart';

class CommentWriteView extends StatelessWidget {
  final String title;
  final String buttonText;
  final String commentIndex;
  final String? replyingTo;
  final Comment comment;
  final Function(int)? onScoreChange;

  const CommentWriteView({
    required this.title,
    required this.commentIndex,
    required this.comment,
    required this.onScoreChange,
    required this.buttonText,
    this.replyingTo,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Dependency.get<CommentsViewController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
        backgroundColor: Theme.of(context).backgroundColor,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: (){if(FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();},
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 30.h
          ),
          children: [
            CommentCard(
              commentIndex: commentIndex.toString(),
              comment: comment,
              onScoreChange: onScoreChange,
              showControlButtons: false,
            ),
            SizedBox(height: 30.h),
            Center(
              child: Column(
                children: [
                  Input('', 
                    hint: title, 
                    maxLines: 3,
                    controller: controller.commentWriteInputController,
                    shouldDispose: false,
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Button(text: buttonText, onTap: (){
                        if(FocusScope.of(context).hasFocus) FocusScope.of(context).unfocus();
                        if(replyingTo != null){
                          controller.replyComment(replyingTo!, commentIndex);
                        }else{
                          controller.updateComment(commentIndex);
                        }
                        Navigator.of(context).pop();
                        controller.commentWriteInputController.textController.text = '';
                      }))
                    ],
                  )
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}