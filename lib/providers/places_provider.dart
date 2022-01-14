import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:great_places/helpers/db_helper.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/models/place_model.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String Id) {
    return _items.firstWhere((element) => element.id == Id);
  }

  Future<void> addPlace(
      String pickedTitle, File pickedImage, PlaceLocation placeLocation) async {
    final address = await LocationHelper.getPlacesAddress(
        latitude: placeLocation.latitude, longtitude: placeLocation.longitude);

    final updatedPlaceLocation = PlaceLocation(
        latitude: placeLocation.latitude,
        longitude: placeLocation.longitude,
        address: address);

    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        title: pickedTitle,
        location: updatedPlaceLocation);
    _items.add(newPlace);

    DBHelper.insertData('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address
    });
    print("_items ${items[0].image}");
    notifyListeners();
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((e) => Place(
            id: e['id'],
            title: e['title'],
            image: File(e['image']),
            location: PlaceLocation(
                latitude: e['loc_lat'],
                longitude: e['loc_lng'],
                address: e['address'])))
        .toList();
    notifyListeners();
  }
}
