import 'package:comment_section/app/Button/link_button.dart';
import 'package:comment_section/app/Dependency/dependency.dart';
import 'package:comment_section/app/Text/typography.dart';
import 'package:comment_section/app/Text/ui_text.dart';
import 'package:comment_section/app/application.dart';
import 'package:comment_section/src/comments/models/comment.dart';
import 'package:comment_section/src/comments/views/CommentWriteView/comment_write_view.dart';
import 'package:comment_section/src/comments/views/CommentsView/comments_view_controller.dart';
import 'package:comment_section/src/comments/widget/CommentScoreCounter/comment_score_counter.dart';
import 'package:comment_section/src/comments/widget/CommentTag/comment_tag.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String commentIndex;
  final Comment comment;
  final Comment? parentComment;
  final Function(int)? onScoreChange;
  final controller = Dependency.get<CommentsViewController>();
  final Function? onTap;
  final bool showControlButtons;

  CommentCard({
    required this.comment,
    required this.commentIndex,
    this.parentComment,
    this.onScoreChange,
    this.onTap,
    this.showControlButtons = true,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFromCurrentUser = comment.user.username == 
    controller.comments!.value['currentUser']['username'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(comment.replyingTo!.isEmpty) SizedBox(height: 30.h),
        Hero(
          tag: 'target-comment$commentIndex',
          flightShuttleBuilder: (BuildContext flightContext,
              Animation<double> animation,
              HeroFlightDirection flightDirection,
              BuildContext fromHeroContext,
              BuildContext toHeroContext,){

            return SingleChildScrollView(
              child: fromHeroContext.widget,
            );
          },
          child: Material(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.h,
                horizontal: 20.w
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(comment.user.image!.png),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UIText.body1(comment.user.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                              UIText.body2(comment.createdAt, style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                            ],
                          ),
                          if(isFromCurrentUser) const SizedBox(width: 15),
                          if(isFromCurrentUser) const CommentTag(),
                        ],
                      ),
                      if(isFromCurrentUser && showControlButtons) Material(
                        color: Theme.of(context).cardColor,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              color: Theme.of(context).primaryColor,
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                controller.commentWriteInputController.textController.text = comment.content;
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommentWriteView(
                                  title: 'Edit comment', 
                                  commentIndex: commentIndex, 
                                  comment: comment, 
                                  onScoreChange: onScoreChange, 
                                  buttonText: 'EDIT'
                                )));
                                Future.delayed(const Duration(milliseconds: 400), (){
                                  controller.commentWriteInputController.focusNode.requestFocus();
                                });
                              }, 
                            ),
                            IconButton(
                              color: Theme.of(context).colorScheme.error,
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                final confirmation = await controller.showDeleteConfirmationDialog(context);
                                if(confirmation){
                                  controller.deleteComment(commentIndex);
                                }
                              }, 
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  RichText(
                    text: TextSpan(
                      text: comment.replyingTo!.isNotEmpty ? '@${comment.replyingTo} ' : '',
                      style: AppTypography.body1.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 21.fs,
                        fontWeight: FontWeight.bold
                      ),
                      children: <TextSpan>[
                        TextSpan(text: comment.content, style: AppTypography.body1.copyWith(
                          fontSize: 21.fs,
                          color: Theme.of(context).colorScheme.onSurface)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommentScoreCounter(
                        active: showControlButtons,
                        score: comment.score,
                        onChange: (score){ 
                          comment.score = score; 
                          if(onScoreChange != null){
                            onScoreChange!(score);
                          }
                        },
                      ),
                      const Expanded(child: SizedBox()),
                      if(showControlButtons) Expanded(child: LinkButton(
                        text: 'Reply', 
                        icon: Icons.reply,
                        size: LinkButtonSize.small,
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommentWriteView(
                            title: 'Write a reply', 
                            commentIndex: commentIndex, 
                            comment: comment, 
                            onScoreChange: onScoreChange,
                            replyingTo: comment.user.username,
                            buttonText: 'SEND'
                          )));
                          Future.delayed(const Duration(milliseconds: 400), (){
                            controller.commentWriteInputController.focusNode.requestFocus();
                          });
                        }
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        if(comment.replies.isNotEmpty && showControlButtons) SizedBox(height: 20.h),
        if(comment.replies.isNotEmpty && showControlButtons) ...List<Widget>.generate(
          comment.replies.length, 
          (index) => IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 3,
                  height: 25,
                  color: Theme.of(context).disabledColor,
                ),
                SizedBox(width: 13.w),
                Expanded(child: Padding(
                  padding: EdgeInsets.only(bottom: index == comment.replies.length-1 ? 0 : 15.h),
                  child: Center(child: CommentCard(comment: comment.replies[index], commentIndex: '$commentIndex:$index', parentComment: comment)),
                ))
              ],
            ),
          )
        )
      ],
    );
  }
}