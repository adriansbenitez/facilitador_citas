import 'package:bloc/bloc.dart';

import '../../models/models.dart';
import '../app_bloc.dart';
import 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationState.loading);

  Future<bool> onCheck() async {
    ///Event load user
    UserModel? user = await AppBloc.userCubit.onLoadUser();

    if (user != null) {

      ///Save user
      await AppBloc.userCubit.onSaveUser(user);

      ///Load wishList
      //AppBloc.wishListCubit.onLoad();

      ///Fetch user
      AppBloc.userCubit.onFetchUser();

      ///Notify
      emit(AuthenticationState.success);
      return true;
    } else {
      ///Notify
      onLogout();
      emit(AuthenticationState.fail);
      return false;
    }
  }

  Future<void> onSave(UserModel user) async {
    ///Notify
    emit(AuthenticationState.loading);

    ///Event Save user in preferences and keep state
    await AppBloc.userCubit.onSaveUser(user);

    ///Load wishList
    //AppBloc.wishListCubit.onLoad();

    /// Notify
    emit(AuthenticationState.success);
  }

  void onLogout() {
    /// Notify
    emit(AuthenticationState.fail);

    ///Delete user
    AppBloc.userCubit.onDeleteUser();
  }

}
