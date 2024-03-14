

class Place {
  final String title;
  final double latitude;
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