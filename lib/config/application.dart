import 'package:package_info_plus/package_info_plus.dart';
import '../models/models.dart';

class Application {
  static bool debug = true;
  static String googleAPI = 'AIzaSyCBU1DihLabJ0F1i6Rv-Hyetgdhfo0o9Rk';
  static String domain = 'http://192.168.1.7:8000';
  static PackageInfo? packageInfo;
  static DeviceModel? device;

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
