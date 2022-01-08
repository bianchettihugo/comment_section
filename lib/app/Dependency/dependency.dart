import 'package:comment_section/app/Dependency/dependency_factory.dart';

class Dependency {
  static final Map<String, DependencyFactory<Object>> _dependencies = {};

  static void register<T extends Object>(T Function() build, {bool isSingleton = false, String key = ''}){
    final dependencyKey = '${T.toString()}:$key';
    _dependencies.putIfAbsent(dependencyKey, () => DependencyFactory<T>(
      builder: build,
      isSingleton: isSingleton
    ));
  }

  static T get<T extends Object>({String key = ''}){
    final dependencyKey = '${T.toString()}:$key';
    final dependencyFactory = _dependencies[dependencyKey];
    if(dependencyFactory != null){
      return dependencyFactory.build() as T;
    }

    throw Exception('No dependency found');
  }

  static void dispose(){
    _dependencies.clear();
  }
}