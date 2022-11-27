import 'dart:convert';

class CustomerReponseModel {
  CustomerReponseModel({
    required this.message,
  });

  String message;

  factory CustomerReponseModel.fromJson(String str) =>
      CustomerReponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerReponseModel.fromMap(Map<String, dynamic> json) =>
      CustomerReponseModel(
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
      };
}
