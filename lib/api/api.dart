import 'dart:convert';
import 'dart:typed_data';

import 'package:facilitador_citas/models/models.dart';

import '../models/models.dart';
import 'http_manager.dart';

class Api {
  static final httpManager = HTTPManager();

  ///URL API
  static const String login = "/api/auth/login";
  static const String banner = "/api/plan/banner";
  static const String location = "/api/locations";
  static const String service = "/api/services";
  static const String serviceById = "/api/services/:id";
  static const String customer = "/api/customers";
  static const String customerChangeImage = "/api/gateway/media";
  static const String changePassword = "/api/user/:userId/changepwd";
  static const String forgotPassword = "/api/password/email";
  static const String categories = "/api/categories";

  ///Login api
  static Future<UserModel?> requestLogin(params) async {
    final result = await httpManager.post(url: login, data: params);
    if (result['message'] != null) return null;
    return UserModel.fromMap(result);
  }

  ///Get Banner
  static Future<BannerModel> getBanner() async {
    final result = await httpManager.get(url: banner);
    return BannerModel.fromMap(result);
  }

  ///Get Locations
  static Future<LocationModel> getLocations() async {
    final result = await httpManager.get(url: location);
    return LocationModel.fromMap(result);
  }

  ///Get Services
  static Future<ServicesModel> getServices() async {
    final result = await httpManager.get(url: service);
    return ServicesModel.fromMap(result);
  }

  /// Get service by id
  static Future<ServicesModel> getServiceById(serviceId) async {
    final result = await httpManager.get(
        url: serviceById.replaceFirst(":id", serviceId.toString()));
    return ServicesModel.fromMap(result);
  }

  /// Get service by location id
  static Future<ServicesModel> getServiceByLocationId(locationId) async {
    final result =
        await httpManager.get(url: service, params: {'location': locationId});
    return ServicesModel.fromMap(result);
  }

  /// Get search Service
  static Future<ServicesModel> getSearchService(params) async {
    final result = await httpManager.get(url: service, params: params);
    return ServicesModel.fromMap(result);
  }

  /// Get Customer by ID
  static Future<CustomerModel> getCustomer(int userId) async {
    final result = await httpManager.get(url: "$customer?user_id=$userId");
    return CustomerModel.fromJson(result['response'][0]);
  }

  /// Get Categories
  static Future<CategorieModel> getCategories() async {
    final result = await httpManager.get(url: categories);
    return CategorieModel.fromMap(result);
  }

  ///Forgot password
  static Future<ForgotPasswordModel> requestForgotPassword(params) async {
    Map<String, dynamic> result = await httpManager.post(
      url: forgotPassword,
      data: params,
      loading: true,
    );
    return ForgotPasswordModel.fromMap(result);
  }

  ///Register Customer
  static Future<CustomerReponseModel> requestRegisterCustomer(params) async {
    final result = await httpManager.post(
      url: customer,
      data: params,
      loading: true,
    );
    return CustomerReponseModel.fromMap(result);
  }

  /// Update Customer
  static Future<dynamic> updateCustomer(customerId, params) async {
    final result = await httpManager.post(
      url: "$customer/$customerId/edit",
      data: params,
      loading: true,
    );
    final convertResponse = {
      "success": result['message'] == "Succesfuly update customer!",
      "message": result['code'] ?? "update_info_success",
      "data": result['response']
    };
    return convertResponse;
  }

  static Future<ChangeResponseModel> requestChangeImage(
      file, sourceType, sourceId, progress) async {
    Uint8List imagebytes = await file.readAsBytes();
    final changeImageRequest = ChangeImageModel(
        sourceType: sourceType,
        sourceId: sourceId,
        profileImage: base64.encode(imagebytes));

    var result = await httpManager.post(
      url: customerChangeImage,
      data: json.encode(changeImageRequest.toJson()),
      progress: progress,
    );
    return ChangeResponseModel.fromMap(result);
  }

  ///change password
  static Future<dynamic> requestChangePassword(params, userId) async {
    final result = await httpManager.post(
      url: changePassword.replaceFirst(":userId", userId.toString()),
      data: params,
      loading: true,
    );
    final convertResponse = {
      "success": result['response'] != null,
      "message": result['message'] ?? "change_password_success",
      "data": result
    };
    return convertResponse;
  }

  ///Singleton factory
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();
}
