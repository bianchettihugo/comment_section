import 'package:flutter/material.dart';

/// The controller of [Input] widget. This class stores its
/// [FocusNode], [TextEditingController] and validate function
class InputController  {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textController = TextEditingController();

  String? Function()? validate;

}
