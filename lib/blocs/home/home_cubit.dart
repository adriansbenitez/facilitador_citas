import 'package:bloc/bloc.dart';
import 'package:facilitador_citas/models/models.dart';
import 'package:facilitador_citas/repository/service_repository.dart';

import '../../repository/repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());

  Future<void> onLoad() async {
    ///Fetch API Home
    final BannerModel? banner = await BannerRepository.loadBanner();

    final LocationModel? location = await LocationRepository.loadLocations();

    final ServicesModel? services = await ServiceRepository.loadServices();

    ///Notify
    emit(HomeSuccess(
        banner: banner,
        location: location,
        recentsServices: services));
  }
}
