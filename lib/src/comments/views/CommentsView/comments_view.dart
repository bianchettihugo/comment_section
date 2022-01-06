import 'package:comment_section/app/application.dart';
import 'package:comment_section/src/comments/models/comment.dart';
import 'package:comment_section/src/comments/views/CommentsView/comments_view_controller.dart';
import 'package:comment_section/src/comments/widget/CommentCard/comment_card.dart';
import 'package:comment_section/src/users/models/user.dart';
import 'package:comment_section/src/users/models/user_image.dart';
import 'package:flutter/material.dart';

class CommentsView extends StatelessWidget {
  final CommentsViewController controller = CommentsViewController();

  CommentsView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final comment = Comment(
      id: 1, 
      content: 'I couldn\'t agree more with this. Everything moves so fast and it always seems like everyone knows the newest library/framework. But the fundamentals are what stay constant.', 
      createdAt: '2 week ago', 
      user: User(username: 'amyrobson', image: UserImage(png: 'images/avatars/image-amyrobson.png')),
      replies: [
        Comment(
          id: 2, 
          content: 'Woah, your project looks awesome! How long have you been coding for? I\'m still new, but think I want to dive into React as well soon. Perhaps you can give me an insight on where I can learn React? Thanks!', 
          createdAt: '2 week ago',
          replyingTo: 'amyrobson',
          user: User(username: 'maxblagun', image: UserImage(png: 'images/avatars/image-maxblagun.png')),
        ),
        Comment(
          id: 3, 
          content: 'Impressive! Though it seems the drag feature could be improved. But overall it looks incredible. You\'ve nailed the design and the responsiveness at various breakpoints works really well.', 
          createdAt: '1 week ago',
          replyingTo: 'maxblagun',
          user: User(username: 'amyrobson', image: UserImage(png: 'images/avatars/image-amyrobson.png')),
        )
      ]
    );

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 40.h,
              horizontal: 25.w
            ),
            child: ListView(
              children: [
                CommentCard(comment: comment),
              ],
            )
          ),
          /*Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 25.w
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [CommentField()],
            ),
          )*/
        ],
      ),
    );
  }
}