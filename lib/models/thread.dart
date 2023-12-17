// To parse this JSON data, do
//
//     final threads = threadsFromJson(jsonString);
/*
import 'dart:convert';


List<Thread> threadFromJson(String str) => List<Thread>.from(json.decode(str).map((x) => Thread.fromJson(x)));

String threadToJson(List<Thread> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Thread {
  String model;
  int pk;
  Fields fields;

  Thread({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Thread.fromJson(Map<String, dynamic> json) => Thread(
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
  String name;
  String date;
  String buku;

  Fields({
    required this.user,
    required this.name,
    required this.date,
    required this.buku,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    name: json["name"],
    date: json["date"],
    buku: json["buku"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "name": name,
    "date": date,
    "buku": buku,
  };
}
*/
// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Thread> threadFromJson(String str) =>
    List<Thread>.from(json.decode(str).map((x) => Thread.fromJson(x)));

String threadToJson(List<Thread> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Thread {
  String model;
  int pk;
  Fields fields;

  Thread({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Thread.fromJson(Map<String, dynamic> json) => Thread(
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
  String name;
  DateTime date;
  dynamic buku;

  Fields({
    required this.user,
    required this.name,
    required this.date,
    required this.buku,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    name: json["name"],
    date: DateTime.parse(json["date_added"]),
    buku: json["buku"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "name": name,
    "date": date.toIso8601String(),
    "buku": buku,
  };
}
