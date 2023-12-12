// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  String body;
  String date;
  int thread;

  Fields({
    required this.user,
    required this.body,
    required this.date,
    required this.thread,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    body: json["body"],
    date: json["date"],
    thread: json["thread"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "body": body,
    "date": date,
    "thread": thread,
  };
}
