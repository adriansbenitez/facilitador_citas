import 'package:bloc/bloc.dart';
import 'package:facilitador_citas/blocs/bloc.dart';
import 'package:facilitador_citas/models/models.dart';
import 'package:facilitador_citas/repository/service_repository.dart';

class ServiceDetailCubit extends Cubit<ServiceDetailState> {
  ServiceDetailCubit() : super(ServiceDetailLoading());
  ServicesModel? service;

  void onLoad(int id) async {
    final result = await ServiceRepository.getServiceById(id);
    if (result != null) {
      service = result;
      emit(ServiceDetailSuccess(service!));
    }
  }

  void onFavorite() {
    /*if (product != null) {
      product!.favorite = !product!.favorite;
      emit(ProductDetailSuccess(product!));
      if (product!.favorite) {
        AppBloc.wishListCubit.onAdd(product!.id);
      } else {
        AppBloc.wishListCubit.onRemove(product!.id);
      }
    }*/
  }
}