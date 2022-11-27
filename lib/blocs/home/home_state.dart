import 'package:facilitador_citas/models/models.dart';

abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final BannerModel? banner;
  final LocationModel? location;
  final ServicesModel? recentsServices;

  HomeSuccess(
      {required this.banner,
      required this.location,
      required this.recentsServices});
}
