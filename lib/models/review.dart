// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  String model;
  int pk;
  Fields fields;

  Review({
    required this.model,
    required this.pk,
    required this.fields,
  });

  Fields getFields(){
    return this.fields;
  }

  factory Review.fromJson(Map<String, dynamic> json) => Review(
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
  dynamic user;
  String review;
  DateTime createdAt;
  int book;
  String username;

  Fields({
    required this.user,
    required this.review,
    required this.createdAt,
    required this.book,
    required this.username,
  });

  String getReview() {
    return this.review;
  }

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        review: json["review"],
        createdAt: DateTime.parse(json["created_at"]),
        book: json["book"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "review": review,
        "created_at": createdAt.toIso8601String(),
        "book": book,
        "username": username,
      };
}
