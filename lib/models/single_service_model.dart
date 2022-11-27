import 'dart:convert';

import 'package:facilitador_citas/models/models.dart';

class SingleServiceModel {
  SingleServiceModel({
    required this.id,
    required this.name,
    required this.price,
    required this.isVisible,
    required this.duration,
    this.timeslotLength,
    this.bufferBefore,
    this.bufferAfter,
    this.notes,
    required this.image,
    this.isRecurring,
    this.fullPeriodType,
    this.fullPeriodValue,
    this.repeatType,
    this.recurringPaymentType,
    this.repeatFrequency,
    this.isFixTime,
    this.minCapacity,
    this.maxCapacity,
    this.color,
    required this.depositType,
    this.deposit,
    required this.activateZoom,
    required this.categorieId,
    this.lang,
    this.hideDuration,
    this.hidePrice,
    this.order,
    required this.categorie,
    required this.staffs,
    required this.locations,
    required this.lat,
    required this.long,
  });

  int id;
  String name;
  int price;
  int isVisible;
  int duration;
  dynamic timeslotLength;
  dynamic bufferBefore;
  dynamic bufferAfter;
  dynamic notes;
  String image;
  dynamic isRecurring;
  dynamic fullPeriodType;
  dynamic fullPeriodValue;
  dynamic repeatType;
  dynamic recurringPaymentType;
  dynamic repeatFrequency;
  dynamic isFixTime;
  dynamic minCapacity;
  dynamic maxCapacity;
  dynamic color;
  String depositType;
  dynamic deposit;
  int activateZoom;
  int categorieId;
  dynamic lang;
  dynamic hideDuration;
  dynamic hidePrice;
  int? order;
  Categorie categorie;
  List<StaffModel> staffs;
  List<SingleLocationModel> locations;
  double lat;
  double long;

  bool get isActive {
    return isVisible == 1;
  }

  factory SingleServiceModel.fromJson(String str) =>
      SingleServiceModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleServiceModel.fromMap(Map<String, dynamic> json) =>
      SingleServiceModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        isVisible: json["is_visible"],
        duration: json["duration"],
        timeslotLength: json["timeslot_length"],
        bufferBefore: json["buffer_before"],
        bufferAfter: json["buffer_after"],
        notes: json["notes"],
        image: json["image"],
        isRecurring: json["is_recurring"],
        fullPeriodType: json["full_period_type"],
        fullPeriodValue: json["full_period_value"],
        repeatType: json["repeat_type"],
        recurringPaymentType: json["recurring_payment_type"],
        repeatFrequency: json["repeat_frequency"],
        isFixTime: json["is_fix_time"],
        minCapacity: json["min_capacity"],
        maxCapacity: json["max_capacity"],
        color: json["color"],
        depositType: json["deposit_type"],
        deposit: json["deposit"],
        activateZoom: json["activate_zoom"],
        categorieId: json["categorie_id"],
        lang: json["lang"],
        hideDuration: json["hide_duration"],
        hidePrice: json["hide_price"],
        order: json["order"] ?? 0,
        categorie: Categorie.fromMap(json["categorie"]),
        staffs: List<StaffModel>.from(
            json["staffs"].map((x) => StaffModel.fromMap(x))),
        locations: List<SingleLocationModel>.from(
            json["locations"].map((x) => SingleLocationModel.fromMap(x))),
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "is_visible": isVisible,
        "duration": duration,
        "timeslot_length": timeslotLength,
        "buffer_before": bufferBefore,
        "buffer_after": bufferAfter,
        "notes": notes,
        "image": image,
        "is_recurring": isRecurring,
        "full_period_type": fullPeriodType,
        "full_period_value": fullPeriodValue,
        "repeat_type": repeatType,
        "recurring_payment_type": recurringPaymentType,
        "repeat_frequency": repeatFrequency,
        "is_fix_time": isFixTime,
        "min_capacity": minCapacity,
        "max_capacity": maxCapacity,
        "color": color,
        "deposit_type": depositType,
        "deposit": deposit,
        "activate_zoom": activateZoom,
        "categorie_id": categorieId,
        "lang": lang,
        "hide_duration": hideDuration,
        "hide_price": hidePrice,
        "order": order,
        "categorie": categorie.toMap(),
        "staffs": List<dynamic>.from(staffs.map((x) => x.toMap())),
        "locations": List<dynamic>.from(locations.map((x) => x.toMap())),
        "lat": lat,
        "long": long,
      };
}
