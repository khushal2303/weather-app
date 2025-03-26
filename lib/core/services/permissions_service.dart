import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/exception/location_%20exception.dart';

abstract class PermissionsService {
  Future<Position?> requestCurrentLocation();

  Future<void> openAppSettings();
}

class PermissionsServiceImpl extends PermissionsService {
  @override
  Future<Position?> requestCurrentLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionException('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw LocationPermissionPermanentlyDeniedException(
          'Location permissions are permanently denied, we cannot request permissions.\nYou can allow permission from settings');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  @override
  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}
