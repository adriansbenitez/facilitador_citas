import 'package:bloc/bloc.dart';
import 'package:facilitador_citas/models/models.dart';
import 'package:facilitador_citas/repository/repository.dart';

import '../../models/models.dart';
import 'cubit.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListLoading());

  int page = 1;
  List<SingleServiceModel> list = [];
  PaginationModel? pagination;

  Future<void> onLoadServicesByLocation(int locationId) async {
    //Obtener listado de servicios
    ServicesModel? servicesModel =
        await LocationRepository.getServicesByLocationId(locationId);

    if (servicesModel != null) {
      list = servicesModel.singleServices;
      emit(ListSuccess(
        list: list,
        canLoadMore: false,
      ));
    }
    /* page = 1;

    ///Fetch API
    final result = await ListRepository.loadList(
      page: page,
      perPage: Application.setting.perPage,
      filter: filter,
    );
    if (result != null) {
      list = result[0];
      pagination = result[1];

      ///Notify
      mit(ListSuccess(
        list: list,
        canLoadMore: pagination!.page < pagination!.maxPage,
      ));
    }*/
  }

  Future<void> onLoadMore(FilterModel filter) async {
    page = page + 1;

    ///Notify
    emit(ListSuccess(
      loadingMore: true,
      list: list,
      canLoadMore: pagination!.page < pagination!.maxPage,
    ));

    ///Fetch API
    /*final result = await ListRepository.loadList(
      page: page,
      perPage: Application.setting.perPage,
      filter: filter,
    );
    if (result != null) {
      list.addAll(result[0]);
      pagination = result[1];

      ///Notify
      emit(ListSuccess(
        list: list,
        canLoadMore: pagination!.page < pagination!.maxPage,
      ));
    }*/
  }

  Future<void> onUpdate(int id) async {
    /*try {
      final exist = list.firstWhere((e) => e.id == id);
      final result = await ListRepository.loadProduct(id);
      if (result != null) {
        list = list.map((e) {
          if (e.id == exist.id) {
            return result;
          }
          return e;
        }).toList();

        ///Notify
        emit(ListSuccess(
          list: list,
          canLoadMore: pagination!.page < pagination!.maxPage,
        ));
      }
    } catch (error) {
      UtilLogger.log("LIST NOT FOUND UPDATE");
    }*/
  }
}
