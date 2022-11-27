import 'package:facilitador_citas/blocs/bloc.dart';
import 'package:facilitador_citas/widgets/widgets.dart';

import '../api/api.dart';
import '../blocs/bloc.dart';
import '../models/models.dart';

class ServiceRepository {
  static Future<ServicesModel?> loadServices() async {
    final serviceModel = await Api.getServices();
    if (serviceModel.message == 'Success') {
      return serviceModel;
    }
    AppBloc.messageCubit.onShow(serviceModel.message, MessageStatusType.error);
    return null;
  }

  static Future<ServicesModel?> getServiceById(serviceId) async {
    final servicesModel = await Api.getServiceById(serviceId);
    if (servicesModel.message == 'Success') {
      return servicesModel;
    }
    AppBloc.messageCubit.onShow(servicesModel.message, MessageStatusType.error);
    return null;
  }

  static Future<List<SingleServiceModel>> getSearchService(keyword) async {
    final servicesModel = await Api.getSearchService({'keyword': keyword});
    if (servicesModel != null) {
      return servicesModel.singleServices;
    }
    return [];
  }
}
