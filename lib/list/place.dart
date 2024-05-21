
import 'package:geo_sort/geo_sort.dart';

class Place implements HasLocation {
  final String title;
  @override
  final double latitude;
  @override
  final double longitude;
  String address;
  bool selected;


  Place({
    required this.title,
    required this.latitude,
    required this.longitude,
    this.address = '',
    this.selected = false,
    });
}