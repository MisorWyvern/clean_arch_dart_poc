class QuestDTO {
  final int id;
  final String name;
  final String description;

  QuestDTO({this.id, this.name, this.description});

  static Map<String, dynamic> toMap(QuestDTO dto) => {
        "id": dto?.id ?? 0,
        "name": dto?.name ?? "",
        "description": dto?.description ?? "",
      };

  static QuestDTO fromMap(Map<String, dynamic> map) => QuestDTO(
        id: map["id"] ?? 0,
        name: map["name"] ?? "",
        description: map["description"] ?? "",
      );

  @override
  String toString() => 'QuestDTO(name: $name, description: $description)';
}
