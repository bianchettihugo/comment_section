import 'package:comment_section/app/Button/button.dart';
import 'package:comment_section/app/Input/input.dart';
import 'package:comment_section/app/application.dart';
import 'package:flutter/material.dart';

class CommentField extends StatelessWidget {
  const CommentField({ Key? key }) : super(key: key);

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
          const Input('', hint: 'Add a comment', maxLines: 3),
          SizedBox(height: 25.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: const Text('UN'),
              ),
              const Expanded(child: SizedBox(), flex: 2),
              Expanded(child: Button(text: 'SEND', onTap: (){}))
            ],
          )
        ],
      ),
    );
  }
}