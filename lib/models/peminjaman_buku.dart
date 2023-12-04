// To parse this JSON data, do
//
//     final peminjamanBuku = peminjamanBukuFromJson(jsonString);

import 'dart:convert';

List<PeminjamanBuku> peminjamanBukuFromJson(String str) => List<PeminjamanBuku>.from(json.decode(str).map((x) => PeminjamanBuku.fromJson(x)));

String peminjamanBukuToJson(List<PeminjamanBuku> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PeminjamanBuku {
    String model;
    int pk;
    Fields fields;

    PeminjamanBuku({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory PeminjamanBuku.fromJson(Map<String, dynamic> json) => PeminjamanBuku(
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
    String nama;
    DateTime tanggalPeminjaman;
    DateTime tanggalPengembalian;
    bool isDikembalikan;
    String gambarBuku;
    String title;

    Fields({
        required this.user,
        required this.buku,
        required this.nama,
        required this.tanggalPeminjaman,
        required this.tanggalPengembalian,
        required this.isDikembalikan,
        required this.gambarBuku,
        required this.title,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        buku: json["buku"],
        nama: json["nama"],
        tanggalPeminjaman: DateTime.parse(json["tanggal_peminjaman"]),
        tanggalPengembalian: DateTime.parse(json["tanggal_pengembalian"]),
        isDikembalikan: json["is_dikembalikan"],
        gambarBuku: json["gambarBuku"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "buku": buku,
        "nama": nama,
        "tanggal_peminjaman": "${tanggalPeminjaman.year.toString().padLeft(4, '0')}-${tanggalPeminjaman.month.toString().padLeft(2, '0')}-${tanggalPeminjaman.day.toString().padLeft(2, '0')}",
        "tanggal_pengembalian": "${tanggalPengembalian.year.toString().padLeft(4, '0')}-${tanggalPengembalian.month.toString().padLeft(2, '0')}-${tanggalPengembalian.day.toString().padLeft(2, '0')}",
        "is_dikembalikan": isDikembalikan,
        "gambarBuku": gambarBuku,
        "title": title,
    };
}
