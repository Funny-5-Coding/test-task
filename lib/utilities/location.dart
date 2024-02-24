import 'package:geolocator/geolocator.dart';

/**
 * For getting current location uses [Geolocator] package
 * with [LocationAccuracy.best] accuracy 
 */

/// [Location] class for getting current location
class Location {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      throw 'Something goes wrong';
    }
  }
}
