import 'package:geo_sort/geo_sort.dart';
import 'package:geolocator/geolocator.dart';
import '../list/place.dart';

class Trip {
  Future<List<Place>> BuildTrip (List<Place> places) async{
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final sortedLocations = GeoSort.sortByLatLong(
      items: places,
      latitude: position.latitude,
      longitude: position.longitude,
      ascending: true,
    );
    return sortedLocations;
  }
}