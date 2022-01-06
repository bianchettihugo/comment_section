import 'package:comment_section/app/Button/tap_validator.dart';
import 'package:comment_section/app/Text/ui_text.dart';
import 'package:comment_section/app/application.dart';
import 'package:flutter/material.dart';


enum LinkButtonSize {
  big, small
}

class LinkButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function() onTap;
  final TapValidator _tapValidator = TapValidator();
  final double opacity;
  final LinkButtonSize size;

  LinkButton({Key? key, 
    required this.text,
    required this.onTap,
    this.icon,
    this.opacity = 1,
    this.size = LinkButtonSize.big
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    final fontType = size == LinkButtonSize.big ? UIText.heading4 : UIText.body1;
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
      label: fontType(text, style: TextStyle(
        color: Theme.of(context).primaryColor.withOpacity(opacity),
        fontWeight: FontWeight.bold
      ))
    );
  }
}