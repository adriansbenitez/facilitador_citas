import 'package:facilitador_citas/blocs/bloc.dart';
import 'package:facilitador_citas/models/models.dart';

import '../api/api.dart';
import '../blocs/app_bloc.dart';

class LocationRepository {
  static Future<LocationModel?> loadLocations() async {
    final locationModel = await Api.getLocations();
    if (locationModel.message == 'Success') {
      return locationModel;
    }
    AppBloc.messageCubit.onShow(locationModel.message, MessageStatusType.error);
    return null;
  }

  static Future<ServicesModel?> getServicesByLocationId(locationId) async {
    final servicesModel = await Api.getServiceByLocationId(locationId);
    if (servicesModel.message == 'Success') {
      return servicesModel;
    }
    AppBloc.messageCubit.onShow(servicesModel.message, MessageStatusType.error);
    return null;
  }
}
