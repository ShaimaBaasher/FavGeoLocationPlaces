// const GOOGLE_API_KEY = 'AIzaSyD3YdX-jpAvH7_MuQ7J8PVn0nMzuy5G0V0';
import 'dart:convert';

import 'package:http/http.dart' as http;
const GOOGLE_API_KEY = 'AIzaSyCpnteVxyzhH0G_XqOrsZNLYqeSlnwYVLY';

class LocationHelper {

  static String generateLocationPreviewImage({double latitude, double longtitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longtitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longtitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlacesAddress({double latitude, double longtitude}) async {
    print('getPlacesAddress $latitude, $longtitude');
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longtitude&key=$GOOGLE_API_KEY';
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }

}