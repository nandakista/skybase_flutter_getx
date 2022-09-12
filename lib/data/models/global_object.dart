class GlobalObject<I, V> {
  I id;
  String? name;
  String? description;
  V? value;

  GlobalObject({
    required this.id,
    this.value,
    this.name,
    this.description,
  });

  factory GlobalObject.fromJson(Map<String, dynamic> json) => GlobalObject(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );
}
