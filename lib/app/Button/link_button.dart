import 'package:comment_section/app/Button/tap_validator.dart';
import 'package:comment_section/app/Text/ui_text.dart';
import 'package:comment_section/app/application.dart';
import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function() onTap;
  final TapValidator _tapValidator = TapValidator();

  LinkButton({Key? key, 
    required this.text,
    required this.onTap,
    this.icon
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: (){
        if(!_tapValidator.isRedundentClick(DateTime.now())) {
          onTap();
        }
      },
      icon: icon != null ? Transform.translate(
        offset: const Offset(3, -2),
        child: Icon(icon, size: 22.w, color: Theme.of(context).primaryColor),
      ) : const SizedBox.shrink(), 
      label: UIText.heading6(text, style: TextStyle(
        color: Theme.of(context).primaryColor
      ))
    );
  }
}