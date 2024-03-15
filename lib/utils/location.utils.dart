import 'dart:convert';

import '../constants/country.dart';
import 'package:http/http.dart' as http;

final class LocationUtils {
  // /// Get current Location of the device. Returning LatLng Value.
  // static Future<LatLng> get getCurrentLocation async {
  //   Position position = await determinePosition();
  //   return LatLng(position.latitude, position.longitude);
  // }

  // static Future<Position> determinePosition() async {
  //   LocationPermission permission;
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   return await Geolocator.getCurrentPosition();
  // }

  // static LatLng geoPointToLatLng(GeoPoint geoPoint) =>
  //     LatLng(geoPoint.latitude, geoPoint.longitude);

  // static GeoPoint latLngToGeoPoint(LatLng latLng) =>
  //     GeoPoint(latLng.latitude, latLng.longitude);

  static Country countryFromIsoCode(String iso) =>
      Country.values.firstWhere((element) => element.isoCode == iso,
          orElse: () => Country.empty);

  static Country countryFromIso3Code(String iso) =>
      Country.values.firstWhere((element) => element.iso3Code == iso,
          orElse: () => Country.empty);

  static Country countryFromPhoneCode(String code) =>
      Country.values.firstWhere((element) => element.phoneCode == code,
          orElse: () => Country.empty);

  static Future<String> get getCountryPhoneCode async {
    Country? c = await countryFromUrl;
    return c.phoneCode;
  }

  static Future<Country> get countryFromUrl async {
    String isoCode = '';
    var response = await http.get(Uri.parse('https://freeipapi.com/api/json'));
    var jsonResponse = json.decode(response.body);
    isoCode = jsonResponse['countryCode'];
    return isoCode == '' ? Country.empty : countryFromIsoCode(isoCode);
  }
}
