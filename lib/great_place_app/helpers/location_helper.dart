import 'api_key.dart';

class LocationHelper {
  static String genLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    const firebaseHostName = 'maps.googleapis.com';

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
}

//markers=color:red%7Clabel:G%7C13.7189819,100.8639551
