import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_key.dart';

class LocationHelper {
  static const firebaseHostName = 'maps.googleapis.com';

  static String genLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    final url = Uri.https(
      firebaseHostName,
      '/maps/api/staticmap',
      {
        'key': GOOGLE_API_KEY,
        'center': '$latitude,$longitude',
        'zoom': '13',
        'size': '600x300',
        'maptype': 'roadmap',
        'markers': 'color:green|label:H|$latitude,$longitude'
      },
    );
    return url.toString();
  }

  static Future<String> getPlaceAddress(
      double latitude, double longitude) async {
    final url = Uri.https(
      firebaseHostName,
      '/maps/api/geocode/json',
      {
        'key': GOOGLE_API_KEY,
        'latlng': '$latitude,$longitude',
      },
    );
    print('url : $url');

    final response = await http.get(url);
    String address =
        json.decode(response.body)['results'][0]['formatted_address'];
    print('address : $address');

    return address;
  }
}
