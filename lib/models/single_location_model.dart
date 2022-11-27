
import 'dart:convert';

class SingleLocationModel {
  SingleLocationModel({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
    required this.phoneNumber,
    required this.notes,
    this.latitude,
    this.longitude,
    required this.isActive,
  });

  int id;
  String name;
  String image;
  String? address;
  String? phoneNumber;
  String? notes;
  String? latitude;
  String? longitude;
  int isActive;
  String? lang;

  factory SingleLocationModel.fromJson(String str) => SingleLocationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleLocationModel.fromMap(Map<String, dynamic> json) => SingleLocationModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    address: json["address"]?? "",
    phoneNumber: json["phone_number"]?? "",
    notes: json["notes"]?? "",
    latitude: json["latitude"]?? "",
    longitude: json["longitude"]?? "",
    isActive: json["is_active"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "image": image,
    "address": address,
    "phone_number": phoneNumber,
    "notes": notes,
    "latitude": latitude,
    "longitude": longitude,
    "is_active": isActive,
  };
}