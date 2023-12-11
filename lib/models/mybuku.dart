// To parse this JSON data, do
//
//     final myBuku = myBukuFromJson(jsonString);

import 'dart:convert';

List<MyBuku> myBukuFromJson(String str) => List<MyBuku>.from(json.decode(str).map((x) => MyBuku.fromJson(x)));

String myBukuToJson(List<MyBuku> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyBuku {
    String model;
    int pk;
    Fields fields;

    MyBuku({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory MyBuku.fromJson(Map<String, dynamic> json) => MyBuku(
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
    int buku;
    String isi;

    Fields({
        required this.user,
        required this.buku,
        required this.isi,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        buku: json["buku"],
        isi: json["isi"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "buku": buku,
        "isi": isi,
    };
}