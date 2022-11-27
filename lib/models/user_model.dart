import 'dart:convert';

import 'customer_model.dart';

class UserModel {
  UserModel({
    required this.idUser,
    required this.name,
    required this.isPaciente,
    required this.urlLogo,
    required this.accessToken,
    required this.tokenType,
    required this.email,
    required this.customerModel,
  });

  int idUser;
  String name;
  bool isPaciente;
  String urlLogo;
  String accessToken;
  String tokenType;
  String email;

  //metadata
  CustomerModel? customerModel;

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  void updateCustomer(CustomerModel customerModel) {
    this.customerModel = customerModel;
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
      idUser: json["id_user"],
      name: json["name"],
      isPaciente: json["isPaciente"] ?? '',
      urlLogo: json["url_logo"] ?? '',
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      email: json["email"],
      customerModel: json["customerModel"] == null ? null : CustomerModel.fromJson(json["customerModel"]));

  Map<String, dynamic> toMap() => {
        "id_user": idUser,
        "name": name,
        "isPaciente": isPaciente,
        "url_logo": urlLogo,
        "access_token": accessToken,
        "token_type": tokenType,
        "email": email,
        "customerModel": customerModel
      };
}
