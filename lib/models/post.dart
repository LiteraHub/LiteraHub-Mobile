import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

class Post {
  int user;
  dynamic thread;
  String body;
  DateTime date;

  Fields({
    required this.user,
    required this.thread,
    required this.body,
    required this.date,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    thread: json["thread"],
    body: json["body"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "thread": thread,
    "body": body,
    "date": date.toIso8601String(),
  };
}
