import 'package:comment_section/app/Button/link_button.dart';
import 'package:comment_section/app/Text/typography.dart';
import 'package:comment_section/app/Text/ui_text.dart';
import 'package:comment_section/app/application.dart';
import 'package:comment_section/src/comments/models/comment.dart';
import 'package:comment_section/src/comments/widget/CommentScoreCounter/comment_score_counter.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final Comment? parentComment;

  const CommentCard({
    required this.comment,
    this.parentComment,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(comment.replyingTo!.isEmpty) SizedBox(height: 30.h),
        Container(
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(comment.user.image!.png),
                  ),
                  const SizedBox(width: 10),
                  UIText.body1(comment.user.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 25),
                  UIText.body1(comment.createdAt, style: TextStyle(color: Theme.of(context).colorScheme.onSurface))
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
              /*UIText.body1(
                comment.content,
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface)
              ),*/
              SizedBox(height: 25.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommentScoreCounter(
                    score: comment.score,
                    onChange: (score){ comment.score = score; },
                  ),
                  const Expanded(child: SizedBox()),
                  Expanded(child: LinkButton(
                    text: 'Reply', 
                    icon: Icons.reply,
                    size: LinkButtonSize.small,
                    onTap: (){}
                  ))
                ],
              )
            ],
          ),
        ),
        if(comment.replies.isNotEmpty) SizedBox(height: 20.h),
        if(comment.replies.isNotEmpty) ...List<Widget>.generate(
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
                  child: CommentCard(comment: comment.replies[index], parentComment: comment),
                ))
              ],
            ),
          )
        )
      ],
    );
  }
}