import 'package:bloc/bloc.dart';
import '../../repository/user_repository.dart';
import '../app_bloc.dart';
import '../message/message_cubit.dart';

enum LoginState {
  init,
  loading,
  success,
  fail,
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.init);

  void onLogin({
    required String username,
    required String password,
  }) async {
    ///Notify
    emit(LoginState.loading);

    ///login via repository
    final userModel = await UserRepository.login(
      username: username,
      password: password,
    );

    if (userModel != null) {
      ///Begin start Auth flow
      await AppBloc.authenticationCubit.onSave(userModel);

      ///Notify
      emit(LoginState.success);
    } else {
      ///Notify
      emit(LoginState.fail);
      AppBloc.messageCubit.onShow('sign_up_error', MessageStatusType.error);
    }
  }

  void onLogout() async {
    ///Begin start auth flow
    emit(LoginState.init);
    AppBloc.authenticationCubit.onLogout();
  }
}
