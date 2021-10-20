import 'package:device_info/device_info.dart';
import 'package:universal_platform/universal_platform.dart';

class DeviceInfo {
  Future<String> getImei() async {
    String imei;
    final deviceInfo = DeviceInfoPlugin();

    if (UniversalPlatform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      imei = androidInfo.androidId;
      imei = androidInfo.brand;
    } else if (UniversalPlatform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      imei = iosInfo.identifierForVendor;
      imei=iosInfo.model;
    }

    return imei  ;

  }
}
