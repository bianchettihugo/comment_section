import 'package:comment_section/app/Theme/theme.dart';
import 'package:comment_section/src/comments/views/CommentsView/comments_view_controller.dart';
import 'package:comment_section/src/comments/widget/CommentBottomWidget/comment_bottom_widget.dart';
import 'package:comment_section/src/comments/widget/CommentField/comment_field.dart';
import 'package:comment_section/src/comments/widget/CommentsList/comments_list.dart';
import 'package:comment_section/src/comments/widget/CommentsListError/comments_list_error.dart';
import 'package:comment_section/src/comments/widget/CommentsListLoad/comments_list_load.dart';
import 'package:flutter/material.dart';

class CommentsView extends StatefulWidget {

  const CommentsView({ Key? key }) : super(key: key);

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  late CommentsViewController controller = CommentsViewController();

  @override
  void initState() {
    controller.bottomWidget = ValueNotifier(FloatingActionButton(
      child: const Icon(Icons.comment),
      backgroundColor: AppTheme.theme.primaryColor,
      onPressed: (){
        controller.bottomWidget.value = CommentField(controller);
        Future.delayed(const Duration(milliseconds: 500), (){
          controller.commentInputController.focusNode.requestFocus();
        });
      },
    ));
    super.initState();
  }

  @override
  void dispose() {
    controller.commentInputController.focusNode.dispose();
    controller.commentInputController.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: controller.fetchComments,
      builder: (context, snapshot){
        Widget child;
        if (snapshot.hasData) {
          child = Scaffold(
            body: Stack(
              children: [
                CommentsList(controller, snapshot.data!),
                CommentBottomWidget(controller)
              ],
            ),
          );
        } else if (snapshot.hasError) {
          child = CommentsListError(snapshot.error);
        } else {
          child = const CommentsListLoad();
        }

        return child;
      } 
    );
  }
}