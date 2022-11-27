import 'package:facilitador_citas/blocs/bloc.dart';
import 'package:facilitador_citas/models/models.dart';

import '../api/api.dart';
import '../blocs/app_bloc.dart';

class CategorieRepository {
  static Future<CategorieModel?> loadCategories() async {
    final categorieModel = await Api.getCategories();
    if (categorieModel.message == 'Success') {
      return categorieModel;
    }
    AppBloc.messageCubit.onShow(categorieModel.message, MessageStatusType.error);
    return null;
  }
}
