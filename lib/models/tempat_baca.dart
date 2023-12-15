// To parse this JSON data, do
//
//     final tempatBaca = tempatBacaFromJson(jsonString);

import 'dart:convert';

List<TempatBaca> tempatBacaFromJson(String str) => List<TempatBaca>.from(json.decode(str).map((x) => TempatBaca.fromJson(x)));

String tempatBacaToJson(List<TempatBaca> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TempatBaca {
    Model model;
    int pk;
    Fields fields;

    TempatBaca({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory TempatBaca.fromJson(Map<String, dynamic> json) => TempatBaca(
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
    int idTempat;
    bool dipesan;

    Fields({
        required this.idTempat,
        required this.dipesan,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        idTempat: json["id_tempat"],
        dipesan: json["dipesan"],
    );

    Map<String, dynamic> toJson() => {
        "id_tempat": idTempat,
        "dipesan": dipesan,
    };
}

enum Model {
    RESERVASI_TEMPATBACA
}

final modelValues = EnumValues({
    "reservasi.tempatbaca": Model.RESERVASI_TEMPATBACA
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
