import 'package:facilitador_citas/models/models.dart';
import 'package:facilitador_citas/screens/forgot_password/forgot_password.dart';
import 'package:facilitador_citas/screens/search_services/search_services.dart';
import 'package:facilitador_citas/screens/service_detail/service_detail.dart';
import 'package:flutter/material.dart';
import '../screens/screen.dart';

class RouteArguments<T> {
  final T? item;
  final VoidCallback? callback;

  RouteArguments({this.item, this.callback});
}

class Routes {
  static const String home = "/home";
  static const String chat = "/chat";
  static const String account = "/account";
  static const String profile = "/profile";
  static const String setting = "/setting";
  static const String editProfile = "/editProfile";
  static const String changePassword = "/changePassword";
  static const String changeLanguage = "/changeLanguage";
  static const String appointments = "/appointments";
  static const String serviceDetails = "/serviceDetails";
  static const String forgotPassword = "/forgotPassword";
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String searchService = "/searchService";
  static const String gallery = "/gallery";
  static const String listServices = "/listServices";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) {
            return const Home();
          },
          fullscreenDialog: true,
        );
      case appointments:
        return MaterialPageRoute(
          builder: (context) {
            return const Appointments();
          },
          fullscreenDialog: true,
        );
      case chat:
        return MaterialPageRoute(
          builder: (context) {
            return const Chat();
          },
          fullscreenDialog: true,
        );
      case account:
        return MaterialPageRoute(
          builder: (context) {
            return const Account();
          },
          fullscreenDialog: true,
        );
      case serviceDetails:
        return MaterialPageRoute(
          builder: (context) {
            return ServiceDetail(id: settings.arguments as int);
          },
          fullscreenDialog: true,
        );
      case forgotPassword:
        return MaterialPageRoute(
          builder: (context) {
            return const ForgotPassword();
          },
          fullscreenDialog: true,
        );
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (context) {
            return const SignUp();
          },
          fullscreenDialog: true,
        );
      case searchService:
        return MaterialPageRoute(
          builder: (context) {
            return const SearchServices();
          },
          fullscreenDialog: true,
        );
      case setting:
        return MaterialPageRoute(
          builder: (context) {
            return const Setting();
          },
          fullscreenDialog: true,
        );
      case changeLanguage:
        return MaterialPageRoute(
          builder: (context) {
            return const LanguageSetting();
          },
          fullscreenDialog: true,
        );
      case editProfile:
        return MaterialPageRoute(
          builder: (context) {
            return const EditProfile();
          },
          fullscreenDialog: true,
        );
      case changePassword:
        return MaterialPageRoute(
          builder: (context) {
            return const ChangePassword();
          },
        );
      case gallery:
        return MaterialPageRoute(
          builder: (context) {
            return Gallery(service: settings.arguments as SingleServiceModel);
          },
          fullscreenDialog: true,
        );
      case listServices:
        return MaterialPageRoute(
          builder: (context) {
            return ListServices(location: settings.arguments as SingleLocationModel);
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Not Found"),
              ),
              body: Center(
                child: Text('No path for ${settings.name}'),
              ),
            );
          },
        );
    }
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}
