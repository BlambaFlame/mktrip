class AppLatLong {
  final double lat;
  final double long;

  const AppLatLong({
    required this.lat,
    required this.long,
  });
}

class KazanLocation extends AppLatLong {
  const KazanLocation({
    super.lat = 55.796127,
    super.long = 49.106414,
  });
}