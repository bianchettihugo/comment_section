import 'package:comment_section/app/Text/ui_text.dart';
import 'package:flutter/material.dart';

class CommentTag extends StatelessWidget {
  const CommentTag({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(4)
      ),
      child: UIText.body2('YOU', style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onPrimary
      )),
    );
  }
}