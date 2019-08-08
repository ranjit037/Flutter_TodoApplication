import 'dart:convert';

TodoList todoFromJson(String str) {
  final jsonData = json.decode(str);
  return TodoList.fromMap(jsonData);
}

String todoToJson(TodoList data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class TodoList {
  int id;
  String title;
  String description;
  int createdDate;
  bool isChecked;

  TodoList({
    this.id,
    this.title,
    this.description,
    this.createdDate,
    this.isChecked
  });

  factory TodoList.fromMap(Map<String, dynamic> json) => new TodoList(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdDate: json["created_date"],
        isChecked: json["is_checked"] == 1,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "created_date": createdDate,
        "is_checked":isChecked
      };
}
