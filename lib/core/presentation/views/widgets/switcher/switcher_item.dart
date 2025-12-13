/// Model for switcher items
class SwitcherItem {
  final String id;
  final String name;

  const SwitcherItem({required this.id, required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SwitcherItem && runtimeType == other.runtimeType && id == other.id && name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() => 'SwitcherItem(id: $id, name: $name)';
}

