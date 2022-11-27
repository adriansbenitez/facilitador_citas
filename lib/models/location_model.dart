import 'dart:convert';

import 'package:facilitador_citas/models/models.dart';

class LocationModel {
  LocationModel({
    required this.message,
    required this.response,
  });

  String message;
  List<SingleLocationModel> response;

  factory LocationModel.fromJson(String str) =>
      LocationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocationModel.fromMap(Map<String, dynamic> json) => LocationModel(
        message: json["message"],
        response: List<SingleLocationModel>.from(
            json["response"].map((x) => SingleLocationModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "response": List<dynamic>.from(response.map((x) => x.toMap())),
      };
}
