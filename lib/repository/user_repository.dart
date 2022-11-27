import 'dart:convert';
import 'dart:io';

import '../api/api.dart';
import '../blocs/bloc.dart';
import '../config/preferences.dart';
import '../models/models.dart';

class UserRepository {
  ///Fetch api login
  static Future<UserModel?> login({
    required String username,
    required String password,
  }) async {
    UserModel? userModel;
    final Map<String, dynamic> params = {
      "email": username,
      "password": password,
    };
    userModel = await Api.requestLogin(params);

    if (userModel != null) {
      if (userModel.isPaciente) {
        userModel.customerModel = await Api.getCustomer(userModel.idUser);
      }
      await AppBloc.userCubit.onSaveUser(userModel);
      return userModel;
    }
    return null;
  }

  ///Save User
  static Future<bool> saveUser({required UserModel user}) async {
    return await Preferences.setString(
      Preferences.user,
      jsonEncode(user.toJson()),
    );
  }

  ///Load User
  static Future<UserModel?> loadUser() async {
    final result = Preferences.getString(Preferences.user);
    if (result != null) {
      return UserModel.fromJson(jsonDecode(result));
    }
    return null;
  }

  ///Fetch api forgot Password
  static Future<bool> forgotPassword({required String email}) async {
    final Map<String, dynamic> params = {"email": email};
    final response = await Api.requestForgotPassword(params);
    bool isSendLink = response.message == "forms_reset_link_send";
    AppBloc.messageCubit.onShow(response.message,
        isSendLink ? MessageStatusType.success : MessageStatusType.error);
    return isSendLink;
  }

  ///Fetch api register account
  static Future<bool> registerCustomer({
    required String password,
    required String email,
    required String userName,
  }) async {
    final Map<String, dynamic> params = {
      "password": password,
      "email": email,
      "user": userName,
    };
    final response = await Api.requestRegisterCustomer(params);
    bool isRegisterSuccess = response.message == "customer_created_success";
    AppBloc.messageCubit.onShow(
        response.message,
        isRegisterSuccess
            ? MessageStatusType.success
            : MessageStatusType.error);
    return isRegisterSuccess;
  }

  ///Delete User
  static Future<bool> deleteUser() async {
    return await Preferences.remove(Preferences.user);
  }

  ///Fetch api forgot Password
  static Future<bool> changeProfile({
    required int id,
    required String name,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String gender,
    required String description,
  }) async {
    Map<String, dynamic> params = {
      "first_name": name,
      "last_name": lastName,
      "email": email,
      "phone_number": phoneNumber,
      "gender": gender,
      "notes": description,
    };
    final response = await Api.updateCustomer(id, params);
    //AppBloc.messageCubit.onShow(response.message);

    ///Case success
    if (response['success']) {
      return true;
    }
    return false;
  }

  static Future<ChangeResponseModel> uploadProfileUser(
      File file, String sourceType, int sourceId, progress) async {
    return await Api.requestChangeImage(file, sourceType, sourceId, progress);
  }

  ///Fetch api change Password
  static Future<bool> changePassword({
    required String oldpassword,
    required String newpassword,
    required int userId,
  }) async {
    final Map<String, dynamic> params = {
      "oldpassword": oldpassword,
      "newpassword": newpassword
    };
    final response = await Api.requestChangePassword(params, userId);
    bool isSuccessChange = response['success'];
    AppBloc.messageCubit.onShow(response['message'],
        isSuccessChange ? MessageStatusType.success : MessageStatusType.error);
    return isSuccessChange;
  }

/*///Fetch api validToken
  static Future<bool> validateToken() async {
    final response = await Api.requestValidateToken();
    if (response.success) {
      return true;
    }
    AppBloc.messageCubit.onShow(response.message);
    return false;
  }








  ///Save Image
  static Future<ResultApiModel> uploadProfileUser( File file, String sourceType, int sourceId, progress) async {
     return await Api.requestChangeImage(file, sourceType,sourceId, progress);
   }*/
}
