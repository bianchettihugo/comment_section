import 'package:comment_section/app/Button/tap_validator.dart';
import 'package:comment_section/app/Text/ui_text.dart';
import 'package:comment_section/app/application.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function() onTap;
  final TapValidator _tapValidator = TapValidator();
  final VisualDensity _density;


  SecondaryButton({
    required this.text,
    required this.onTap,
    this.icon,
    Key? key,
  }) : _density = VisualDensity.comfortable, super(key: key);


  SecondaryButton.small({
    required this.text,
    required this.onTap,
    this.icon,
    Key? key,
  }) : _density = VisualDensity.compact, super(key: key);


  SecondaryButton.big({
    required this.text,
    required this.onTap,
    this.icon,
    Key? key,
  }) : _density = VisualDensity.standard, super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: (){
        if(!_tapValidator.isRedundentClick(DateTime.now())) {
          onTap();
        }
      },
      style: ButtonStyle(
        visualDensity: _density,
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(width: 2.0, color: Theme.of(context).primaryColor),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(double.infinity, 63.w)
        )
      ), 
      icon: icon != null ? Transform.translate(
        offset: const Offset(-5, -0.7),
        child: Icon(icon, size: 24.w, color: Theme.of(context).primaryColor),
      ) : const SizedBox.shrink(), 
      label: UIText.block(text, style: TextStyle(color: Theme.of(context).primaryColor))
    );
  }
}