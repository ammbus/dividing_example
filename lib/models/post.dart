import 'dart:convert';

class PostEntity {
  final int id;
  final String title;
  final String body;

  PostEntity({
    required this.id,
    required this.title,
    required this.body,
  });
}

class PostModel extends PostEntity {
  PostModel({
    required int id,
    required String title,
    required String body,
  }) : super(id: id, title: title, body: body);

  PostModel copyWith({
    int? id,
    String? title,
    String? body,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  @override
  String toString() => 'PostModel(id: $id, title: $title, body: $body)';

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title && other.body == body;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ body.hashCode;
}

class ErrorModel {
  final String errorMessage;

  ErrorModel({required this.errorMessage});
}
