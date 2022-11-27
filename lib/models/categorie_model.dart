import 'dart:convert';

class CategorieModel {
  CategorieModel({
    required this.message,
    required this.singleCategories,
    required this.code,
  });

  String message;
  List<SingleCategorieModel> singleCategories;
  int code;

  factory CategorieModel.fromJson(String str) =>
      CategorieModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategorieModel.fromMap(Map<String, dynamic> json) => CategorieModel(
        message: json["message"],
        singleCategories: List<SingleCategorieModel>.from(
            json["response"].map((x) => SingleCategorieModel.fromMap(x))),
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "response": List<dynamic>.from(singleCategories.map((x) => x.toMap())),
        "code": code,
      };
}

class SingleCategorieModel {
  SingleCategorieModel({
    required this.id,
    required this.name,
    required this.isActive,
    this.profileImage,
    this.lang,
  });

  int id;
  String name;
  int isActive;
  String? profileImage;
  String? lang;

  factory SingleCategorieModel.fromJson(String str) =>
      SingleCategorieModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleCategorieModel.fromMap(Map<String, dynamic> json) =>
      SingleCategorieModel(
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
        "profile_image": profileImage == null ? null : profileImage,
        "lang": lang ?? '',
      };
}
