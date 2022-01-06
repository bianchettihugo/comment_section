import 'package:comment_section/app/Input/input_controller.dart';
import 'package:comment_section/app/Text/typography.dart';
import 'package:comment_section/app/Text/ui_text.dart';
import 'package:comment_section/app/application.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final InputController? controller;
  final bool shouldDispose;
  final String placeholder;
  final String hint;
  final TextInputType keyboard;
  final bool obscure;
  final bool isPassword;
  final bool useCardBackgroundColor;
  final int maxLines;
  final void Function()? onEditingComplete;
   

  const Input(this.placeholder, {
    this.controller,
    this.shouldDispose = true,
    this.keyboard = TextInputType.text,
    this.obscure = false,
    this.isPassword = false,
    this.hint = '',
    this.useCardBackgroundColor = true,
    this.maxLines = 1,
    this.onEditingComplete,
    Key? key 
  }) : super(key: key);


  @override
  _InputState createState() => _InputState();

}

class _InputState extends State<Input> {
  InputController? controller;
  late bool obscure;

  @override
  void initState() {
    obscure = widget.obscure;
    controller ??= widget.controller ?? InputController();
    super.initState();
  }

  @override
  void dispose() {
    controller!.validate = null;
    if(widget.shouldDispose){
      controller!.focusNode.dispose();
      controller!.textController.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.placeholder.isNotEmpty) Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: UIText.body2(
            widget.placeholder, 
            style: TextStyle(color: Theme.of(context).disabledColor)
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          maxLines: widget.maxLines,
          keyboardType: widget.keyboard,
          style: AppTypography.body1,
          focusNode: controller!.focusNode,
          controller: controller!.textController,
          obscureText: obscure,
          onEditingComplete: widget.onEditingComplete ?? ()=>FocusScope.of(context).nextFocus(),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).disabledColor, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color:Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(8))
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).disabledColor),
              borderRadius: const BorderRadius.all(Radius.circular(8))
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(8))
            ),
            filled: true,
            fillColor: widget.useCardBackgroundColor ? 
            Theme.of(context).cardColor : Theme.of(context).backgroundColor,
            hintText: widget.hint,
            hintStyle: TextStyle(color: Theme.of(context).disabledColor),
            suffixIcon: widget.isPassword ? 
            Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(
                  obscure ? Icons.visibility : Icons.visibility_off 
                ),
                color: Theme.of(context).disabledColor,
                onPressed: (){
                  setState(() {obscure = !obscure;});
                },
              )
            ) : null,
            contentPadding: EdgeInsets.only(
              top: 28.w, bottom: 23.w,
              right: 25.w, left: 20.w
            )
          )
        ),
      ],
    );
  }
}