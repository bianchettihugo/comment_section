import 'package:comment_section/app/Size/size_config.dart';
import 'package:flutter/material.dart';

class ApplicationWidget extends StatelessWidget {
  final Widget child;

  const ApplicationWidget({ required this.child, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: LayoutBuilder(builder: (context, constraints) {
        Application.sizeConfig = SizeConfig(
          constraints: constraints, 
          designSize: const Size(450, 840)
        );
        return Application(
          child: child
        );
      })
    );
  }
}


class Application extends InheritedWidget {
  static SizeConfig? sizeConfig;
  const Application({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static Application of(BuildContext context) {
    final Application? result = context.dependOnInheritedWidgetOfExactType<Application>();
    assert(result != null, 'No Application found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(oldWidget) => false;
}


extension SizeExtension on num {

  double get w => Application.sizeConfig!.setWidth(this);

  double get h => Application.sizeConfig!.setHeight(this);

  double get fs => Application.sizeConfig!.setFontSize(this);
  
}