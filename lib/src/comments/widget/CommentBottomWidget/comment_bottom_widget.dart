import 'package:comment_section/app/Dependency/dependency.dart';
import 'package:comment_section/app/application.dart';
import 'package:comment_section/src/comments/views/CommentsView/comments_view_controller.dart';
import 'package:flutter/material.dart';

class CommentBottomWidget extends StatelessWidget {
  final CommentsViewController controller;

  CommentBottomWidget({ Key? key }) 
  : controller = Dependency.get<CommentsViewController>(), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 25.w
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ValueListenableBuilder(
            valueListenable: controller.bottomWidget,
            builder: (context, hasError, widget) => AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.bounceOut,
              switchOutCurve: Curves.bounceIn,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation, 
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                    alignment: Alignment.bottomRight
                  )
                );
              },
              layoutBuilder: (currentChild, previousChildren){
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                );
              },
              child: Align(
                key: UniqueKey(),
                alignment: Alignment.centerRight,
                child: controller.bottomWidget.value
              ),
            ),
          )
        ],
      ),
    );
  }
}