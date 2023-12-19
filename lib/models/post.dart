// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  String model;
  int pk;
  Fields fields;

  Post({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  int user;
  int thread;
  DateTime date;
  String body;

  Fields({
    required this.user,
    required this.thread,
    required this.date,
    required this.body,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    thread: json["thread"],
    date: DateTime.parse(json["date"]),
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "thread": thread,
    "date": date.toIso8601String(),
    "body": body,
  };
}

enum Model {
  FORUM_POST
}

final modelValues = EnumValues({
  "forum.post": Model.FORUM_POST
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}