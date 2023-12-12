// To parse this JSON data, do
//
//     final reservasi = reservasiFromJson(jsonString);

import 'dart:convert';

List<Reservasi> reservasiFromJson(String str) => List<Reservasi>.from(json.decode(str).map((x) => Reservasi.fromJson(x)));

String reservasiToJson(List<Reservasi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reservasi {
    String model;
    int pk;
    Fields fields;

    Reservasi({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Reservasi.fromJson(Map<String, dynamic> json) => Reservasi(
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
    String nama;
    String noHp;
    int buku;
    int tempatBaca;
    DateTime tanggal;
    String jam;
    String durasiBaca;
    bool selesai;

    Fields({
        required this.user,
        required this.nama,
        required this.noHp,
        required this.buku,
        required this.tempatBaca,
        required this.tanggal,
        required this.jam,
        required this.durasiBaca,
        required this.selesai,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        nama: json["nama"],
        noHp: json["no_hp"],
        buku: json["buku"],
        tempatBaca: json["tempat_baca"],
        tanggal: DateTime.parse(json["tanggal"]),
        jam: json["jam"],
        durasiBaca: json["durasi_baca"],
        selesai: json["selesai"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "nama": nama,
        "no_hp": noHp,
        "buku": buku,
        "tempat_baca": tempatBaca,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "jam": jam,
        "durasi_baca": durasiBaca,
        "selesai": selesai,
    };
}
