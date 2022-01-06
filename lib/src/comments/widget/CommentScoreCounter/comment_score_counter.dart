import 'package:comment_section/app/Button/link_button.dart';
import 'package:comment_section/app/Text/ui_text.dart';
import 'package:flutter/material.dart';

class CommentScoreCounter extends StatefulWidget {
  final int score;
  final Function(int score) onChange;
  const CommentScoreCounter({ required this.onChange, this.score = 0, Key? key }) : super(key: key);

  @override
  _CommentScoreCounterState createState() => _CommentScoreCounterState();
}

class _CommentScoreCounterState extends State<CommentScoreCounter> {
  late int score;

  @override
  void initState() {
    score = widget.score;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 50, child: LinkButton(
            text: '+', 
            opacity: 0.4,
            onTap: (){setState(() {score++; widget.onChange(score);});}
          )),
          const SizedBox(width: 3),
          UIText.heading6(score.toString()),
          const SizedBox(width: 3),
          SizedBox(width: 50, child: LinkButton(
            text: '-',
            opacity: 0.4,
            onTap: (){setState(() {score--; widget.onChange(score);});}
          )),
        ],
      )
    );
  }
}