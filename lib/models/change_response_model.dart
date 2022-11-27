import 'dart:convert';

class ChangeResponseModel {
  ChangeResponseModel({
    required this.message,
    required this.response,
  });

  String message;
  ImgUrlResponseModel response;

  factory ChangeResponseModel.fromJson(String str) =>
      ChangeResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChangeResponseModel.fromMap(Map<String, dynamic> json) =>
      ChangeResponseModel(
        message: json["message"],
        response: ImgUrlResponseModel.fromMap(json["response"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "response": response.toMap(),
      };
}

class ImgUrlResponseModel {
  ImgUrlResponseModel({
    required this.imgUrl,
  });

  String imgUrl;

  factory ImgUrlResponseModel.fromJson(String str) =>
      ImgUrlResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImgUrlResponseModel.fromMap(Map<String, dynamic> json) =>
      ImgUrlResponseModel(
        imgUrl: json["img_url"],
      );

  Map<String, dynamic> toMap() => {
        "img_url": imgUrl,
      };
}
