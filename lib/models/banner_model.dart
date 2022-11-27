import 'dart:convert';

import 'package:facilitador_citas/models/models.dart';

class BannerModel {
  BannerModel({
    required this.message,
    required this.response,
    required this.permission,
  });

  String message;
  List<Response> response;
  PermissionModel permission;

  List<Response> banner() => response;

  factory BannerModel.fromJson(String str) =>
      BannerModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BannerModel.fromMap(Map<String, dynamic> json) => BannerModel(
        message: json["message"],
        response: List<Response>.from(
            json["response"].map((x) => Response.fromMap(x))),
        permission: PermissionModel.fromMap(json["permission"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "response": List<dynamic>.from(response.map((x) => x.toMap())),
        "permission": permission.toMap(),
      };
}


class Response {
  Response({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });

  int id;
  String name;
  String image;
  String description;

  factory Response.fromJson(String str) => Response.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Response.fromMap(Map<String, dynamic> json) => Response(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
      };
}
