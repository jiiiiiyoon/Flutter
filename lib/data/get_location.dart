import 'package:geolocator/geolocator.dart';

class MyLocation {
  double myLatitude = 0.0;
  double myLongitude = 0.0;

  Future<void> getMyCurrentLocation() async {
    try {
      Position myPos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      myLatitude = myPos.latitude;
      myLongitude = myPos.longitude;
    } catch (e) {
      print('error: loading your location');
    }
  }
}
