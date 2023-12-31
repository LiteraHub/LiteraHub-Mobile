// ignore_for_file: constant_identifier_names

import 'dart:convert';

List<Thread> threadFromJson(String str) => List<Thread>.from(json.decode(str).map((x) => Thread.fromJson(x)));

String threadToJson(List<Thread> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Thread {
  Model model;
  int pk;
  Fields fields;

  Thread({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Thread.fromJson(Map<String, dynamic> json) => Thread(
    model: modelValues.map[json["model"]]!,
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": modelValues.reverse[model],
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  int user;
  String name;
  DateTime date;
  int? buku;

  Fields({
    required this.user,
    required this.name,
    required this.date,
    required this.buku,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    name: json["name"],
    date: DateTime.parse(json["date"]),
    buku: json["buku"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "name": name,
    "date": date.toIso8601String(),
    "buku": buku,
  };
}

enum Model {
  FORUM_THREAD
}

final modelValues = EnumValues({
  "forum.thread": Model.FORUM_THREAD
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
