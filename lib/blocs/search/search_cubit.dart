import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:facilitador_citas/repository/repository.dart';

import 'cubit.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(InitialSearchState());
  Timer? timer;

  void onSearch(String keyword) async {
    if (keyword.isNotEmpty) {
      timer?.cancel();
      timer = Timer(const Duration(milliseconds: 500), () async {
        emit(SearchLoading());
        final listServices = await ServiceRepository.getSearchService(keyword);
        emit(SearchSuccess(list: listServices));
      });
    }
  }

  void onClear() {
    emit(InitialSearchState());
  }
}
