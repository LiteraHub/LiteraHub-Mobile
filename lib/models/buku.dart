import 'dart:convert';

List<Buku> bukuFromJson(String str) =>
    List<Buku>.from(json.decode(str).map((x) => Buku.fromJson(x)));

String bukuToJson(List<Buku> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Buku {
  Model model;
  int pk;
  Fields fields;

  Buku({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Buku.fromJson(Map<String, dynamic> json) => Buku(
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
  String isbn;
  String title;
  String author;
  int year;
  String img;
  bool isReady;

  Fields({
    required this.isbn,
    required this.title,
    required this.author,
    required this.year,
    required this.img,
    required this.isReady,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        isbn: json["isbn"],
        title: json["title"],
        author: json["author"],
        year: json["year"],
        img: json["img"],
        isReady: json["is_ready"],
      );

  Map<String, dynamic> toJson() => {
        "isbn": isbn,
        "title": title,
        "author": author,
        "year": year,
        "img": img,
        "is_ready": isReady,
      };
}

enum Model { BUKU_BUKU }

final modelValues = EnumValues({"buku.buku": Model.BUKU_BUKU});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
