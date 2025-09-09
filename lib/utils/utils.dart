import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  Utils._();

  static Future<bool> haveConnection() async {
    final connectivityResults = await Connectivity().checkConnectivity();
    return !connectivityResults.contains(ConnectivityResult.none);
  }

  static Future<bool> havePhotoPermission() async {
    PermissionStatus status = await Permission.photos.status;
    if (status == PermissionStatus.granted) return true;

    final result = await Permission.photos.request();
    if (result == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
    return result == PermissionStatus.granted;
  }

  static DateTime today() {
    final today = DateTime.now();
    return DateTime(today.year, today.month, today.day);
  }

  static String formatRupiah(int amount) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    return formatter.format(amount);
  }
}
