import 'dart:convert';
import 'package:facilitador_citas/models/services_model.dart';

class StaffModel {
  StaffModel({
    required this.id,
    required this.userId,
    required this.email,
    required this.phoneNumber,
    required this.about,
    this.profileImage,
    required this.isActive,
    required this.zoomUser,
    required this.phoneWhatsapp,
    required this.firstName,
    required this.lastName,
    required this.isActivePrescription,
    this.medicoContactId,
    this.institucionTitulo,
    this.firmaElectronica,
    this.sello,
    required this.isWeeklySchedule,
    required this.isVacations,
    required this.isHolidays,
    required this.pivot,
  });

  int id;
  int userId;
  String email;
  String phoneNumber;
  String about;
  dynamic profileImage;
  int isActive;
  String zoomUser;
  String phoneWhatsapp;
  String firstName;
  String lastName;
  int isActivePrescription;
  dynamic medicoContactId;
  dynamic institucionTitulo;
  dynamic firmaElectronica;
  dynamic sello;
  int isWeeklySchedule;
  int isVacations;
  int isHolidays;
  Pivot pivot;

  factory StaffModel.fromJson(String str) => StaffModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StaffModel.fromMap(Map<String, dynamic> json) => StaffModel(
    id: json["id"],
    userId: json["user_id"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    about: json["about"],
    profileImage: json["profile_image"],
    isActive: json["is_active"],
    zoomUser: json["zoom_user"],
    phoneWhatsapp: json["phone_whatsapp"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    isActivePrescription: json["is_active_prescription"],
    medicoContactId: json["MedicoContactId"],
    institucionTitulo: json["institucion_titulo"],
    firmaElectronica: json["firma_electronica"],
    sello: json["sello"],
    isWeeklySchedule: json["is_weekly_schedule"],
    isVacations: json["is_vacations"],
    isHolidays: json["is_holidays"],
    pivot: Pivot.fromMap(json["pivot"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "email": email,
    "phone_number": phoneNumber,
    "about": about,
    "profile_image": profileImage,
    "is_active": isActive,
    "zoom_user": zoomUser,
    "phone_whatsapp": phoneWhatsapp,
    "first_name": firstName,
    "last_name": lastName,
    "is_active_prescription": isActivePrescription,
    "MedicoContactId": medicoContactId,
    "institucion_titulo": institucionTitulo,
    "firma_electronica": firmaElectronica,
    "sello": sello,
    "is_weekly_schedule": isWeeklySchedule,
    "is_vacations": isVacations,
    "is_holidays": isHolidays,
    "pivot": pivot.toMap(),
  };
}