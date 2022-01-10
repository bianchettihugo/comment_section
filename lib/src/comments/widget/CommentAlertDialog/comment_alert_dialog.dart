import 'package:comment_section/app/Button/button.dart';
import 'package:comment_section/app/Text/ui_text.dart';
import 'package:comment_section/app/application.dart';
import 'package:flutter/material.dart';

class CommentAlertDialog extends StatelessWidget {
  final Function onAccept;
  final Function onRefuse;
  const CommentAlertDialog({
    required this.onAccept,
    required this.onRefuse,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            UIText.heading5('Delete Comment', style: TextStyle(color: Theme.of(context).primaryColor)),
            SizedBox(height: 10.h),
            UIText.body1('Are you sure you want to delete this comment? This will remove the comment and can\'t be undone', 
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Button.small(
                    text: 'NO, CANCEL',
                    color: Theme.of(context).colorScheme.onSurface,
                    onTap: () {
                      Navigator.of(context).pop();
                      onRefuse();
                    }
                  )
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Button.small(
                    text: 'YES, DELETE', 
                    color: Theme.of(context).colorScheme.error, 
                    onTap: (){
                      Navigator.of(context).pop();
                      onAccept();
                    }
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}