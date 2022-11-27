import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../config/config.dart';
import '../../models/device_model.dart';
import '../../utils/utils.dart';
import '../app_bloc.dart';
import 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationState.loading);

  ///On Setup Application
  void onSetup() async {

    /// Sleep a while
    await Future.delayed(const Duration(seconds: 5));

    DarkOption? darkOption;
    ///Get old Theme & Font & Language & Dark Mode & Domain
    await Preferences.setPreferences();
    final oldLanguage = Preferences.getString(Preferences.language);
    final oldDarkOption = Preferences.getString(Preferences.darkOption);

    ///Setup Language
    if (oldLanguage != null) {
      AppBloc.languageCubit.onUpdate(Locale(oldLanguage));
    }

    ///check old dark option
    if (oldDarkOption != null) {
      switch (oldDarkOption) {
        case 'off':
          darkOption = DarkOption.alwaysOff;
          break;
        case 'on':
          darkOption = DarkOption.alwaysOn;
          break;
        default:
          darkOption = DarkOption.dynamic;
      }
    }

    ///Setup Theme & Font with dark Option
    AppBloc.themeCubit.onChangeTheme(
      darkOption: darkOption
    );

    ///Setup application & setting
    final results = await Future.wait([
      PackageInfo.fromPlatform(),
      UtilOther.getDeviceInfo()
    ]);
    Application.packageInfo = results[0] as PackageInfo;
    Application.device = results[1] as DeviceModel;

    ///Start location service
    AppBloc.locationCubit.onLocationService();

    ///Authentication begin check
    bool isAuthenticate = await AppBloc.authenticationCubit.onCheck();
    if (isAuthenticate) {
      emit(ApplicationState.completed);
      return;
    }

    ///First or After upgrade version show intro preview app
    final hasReview = Preferences.containsKey(
      '${Preferences.reviewIntro}.${Application.packageInfo?.version}',
    );
    if (hasReview) {
      ///Notify
      emit(ApplicationState.unauthorized);
    } else {
      ///Notify
      emit(ApplicationState.intro);
    }
  }

  /// LOGIN
  void login() {
    emit(ApplicationState.completed);
  }

  ///On Complete Intro
  void onCompletedIntro() async {
    await Preferences.setBool(
      '${Preferences.reviewIntro}.${Application.packageInfo?.version}',
      true,
    );

    ///Notify
    emit(ApplicationState.unauthorized);
  }

  void logout() {
    ///Notify unauthorized
    emit(ApplicationState.unauthorized);
  }
}
