import 'package:facilitador_citas/models/models.dart';

abstract class ServiceDetailState {}

class ServiceDetailLoading extends ServiceDetailState {}

class ServiceDetailSuccess extends ServiceDetailState {
  final ServicesModel service;

  ServiceDetailSuccess(this.service);
}
