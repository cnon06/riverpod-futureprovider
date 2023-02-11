// To parse this JSON data, do
//
//     final factModel = factModelFromJson(jsonString);

import 'dart:convert';

FactModel factModelFromJson(String str) => FactModel.fromJson(json.decode(str));

String factModelToJson(FactModel data) => json.encode(data.toJson());

class FactModel {
  FactModel({
    required this.fact,
    required this.length,
  });

  String fact;
  int length;

  factory FactModel.fromJson(Map<String, dynamic> json) => FactModel(
        fact: json["fact"],
        length: json["length"],
      );

  Map<String, dynamic> toJson() => {
        "fact": fact,
        "length": length,
      };

  @override
  String toString() {
    // return super.toString();
    return 'Fact: $fact, Length: $length ';
  }
}
