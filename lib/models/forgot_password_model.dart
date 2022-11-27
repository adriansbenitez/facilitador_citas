import 'dart:convert';

class ForgotPasswordModel {
  ForgotPasswordModel({
    required this.message,
  });

  String message;

  factory ForgotPasswordModel.fromJson(String str) =>
      ForgotPasswordModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ForgotPasswordModel.fromMap(Map<String, dynamic> json) =>
      ForgotPasswordModel(
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
      };
}
