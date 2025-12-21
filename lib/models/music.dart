sealed class Music {
  final String path;
  final String name;

  const Music({required this.path, required this.name});

  @override
  bool operator ==(Object other) {
    return other is Music &&
        other.path == path &&
        other.name == name &&
        other.runtimeType == runtimeType;
  }

  @override
  int get hashCode => Object.hash(path, name, runtimeType);
}

class BackgroundMusic extends Music{
  const BackgroundMusic({required super.path, required super.name});
}

class EffectMusic extends Music{
  const EffectMusic({required super.path, required super.name});
}