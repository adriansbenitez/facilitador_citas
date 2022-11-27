import 'dart:convert';
import 'package:facilitador_citas/models/models.dart';

class ServicesModel {
  ServicesModel({
    required this.message,
    required this.singleServices,
    this.permission,
    this.related
  });

  String message;
  List<SingleServiceModel> singleServices;
  PermissionModel? permission;
  List<SingleServiceModel>? related;

  factory ServicesModel.fromJson(String str) =>
      ServicesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServicesModel.fromMap(Map<String, dynamic> json) => ServicesModel(
        message: json["message"],
        singleServices: List<SingleServiceModel>.from(
            json["response"].map((x) => SingleServiceModel.fromMap(x))),
        permission: json["permission"] == null ? null : PermissionModel.fromMap(json["permission"]),
        related:json["related"] == null ? null : List<SingleServiceModel>.from(
            json["related"].map((x) => SingleServiceModel.fromMap(x)))
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "response": List<dynamic>.from(singleServices.map((x) => x.toMap())),
      };
}



class Categorie {
  Categorie({
    required this.id,
    required this.name,
    required this.isActive,
    required this.profileImage,
    this.lang,
  });

  int id;
  String name;
  int isActive;
  String profileImage;
  String? lang;

  factory Categorie.fromJson(String str) => Categorie.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Categorie.fromMap(Map<String, dynamic> json) => Categorie(
        id: json["id"],
        name: json["name"],
        isActive: json["is_active"],
        profileImage: json["profile_image"],
        lang: json["lang"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "is_active": isActive,
        "profile_image": profileImage,
        "lang": lang,
      };
}



class Pivot {
  Pivot({
    required this.serviceId,
    required this.staffId,
  });

  int serviceId;
  int staffId;

  factory Pivot.fromJson(String str) => Pivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
        serviceId: json["service_id"],
        staffId: json["staff_id"],
      );

  Map<String, dynamic> toMap() => {
        "service_id": serviceId,
        "staff_id": staffId,
      };
}
