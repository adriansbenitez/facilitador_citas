import 'package:facilitador_citas/models/models.dart';
import 'package:flutter/material.dart';

class FilterModel {
  final List<CategorieModel> category;
  final List<CategorieModel> feature;
  CategorieModel? area;
  CategorieModel? location;
  double? distance;
  double? minPrice;
  double? maxPrice;
  String? color;
  SortModel? sort;
  TimeOfDay? startHour;
  TimeOfDay? endHour;

  FilterModel({
    required this.category,
    required this.feature,
    this.area,
    this.location,
    this.distance,
    this.minPrice,
    this.maxPrice,
    this.color,
    this.sort,
    this.startHour,
    this.endHour,
  });

  factory FilterModel.fromDefault() {
    return FilterModel(
      category: [],
      feature: [],
    );
  }

  factory FilterModel.fromSource(source) {
    return FilterModel(
      category: List<CategorieModel>.from(source.category),
      feature: List<CategorieModel>.from(source.feature),
      area: source.area,
      location: source.location,
      distance: source.distance,
      minPrice: source.minPrice,
      maxPrice: source.maxPrice,
      color: source.color,
      sort: source.sort,
      startHour: source.startHour,
      endHour: source.endHour,
    );
  }

  FilterModel clone() {
    return FilterModel.fromSource(this);
  }
}
