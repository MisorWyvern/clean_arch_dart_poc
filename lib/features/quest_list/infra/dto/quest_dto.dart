import 'package:clean_arch_dart_poc/core/database/entity/entity.dart';

class QuestDTO extends Entity {
  final int id;
  final String name;
  final String description;

  QuestDTO({this.id, this.name, this.description});

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name ?? "",
        "description": description ?? "",
      };

  QuestDTO fromMap(Map<String, dynamic> map) => QuestDTO(
        id: map["id"],
        name: map["name"] ?? "",
        description: map["description"] ?? "",
      );

  @override
  String toString() => 'QuestDTO(name: $name, description: $description)';

  QuestDTO copyWith({
    int id,
    String name,
    String description,
  }) {
    return QuestDTO(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is QuestDTO &&
        o.id == id &&
        o.name == name &&
        o.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
