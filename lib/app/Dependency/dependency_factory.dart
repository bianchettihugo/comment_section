class DependencyFactory<T extends Object> {
  final bool isSingleton;
  final T Function() builder;
  T? _instance;

  DependencyFactory({required this.builder, required this.isSingleton});

  T build() {
    if (isSingleton && _instance != null) {
      return _instance!;
    }

    final instance = builder();
    if (isSingleton) {
      _instance = instance;
    }
    return instance;
  }
}
