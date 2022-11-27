import '../api/api.dart';
import '../blocs/bloc.dart';
import '../models/models.dart';

class BannerRepository {
  static Future<BannerModel?> loadBanner() async {
    final bannerModel = await Api.getBanner();
    if (bannerModel.message == "Success") {
      return bannerModel;
    }
    AppBloc.messageCubit.onShow(bannerModel.message, MessageStatusType.error);
    return null;
  }
}
