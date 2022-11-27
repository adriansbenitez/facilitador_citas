import 'dart:convert';

class PermissionModel {
  PermissionModel({
    required this.view,
    required this.add,
    required this.edit,
    required this.delete,
  });

  bool view;
  bool add;
  bool edit;
  bool delete;

  factory PermissionModel.fromJson(String str) =>
      PermissionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PermissionModel.fromMap(Map<String, dynamic> json) => PermissionModel(
        view: json["view"],
        add: json["add"],
        edit: json["edit"],
        delete: json["delete"],
      );

  Map<String, dynamic> toMap() => {
        "view": view,
        "add": add,
        "edit": edit,
        "delete": delete,
      };
}
