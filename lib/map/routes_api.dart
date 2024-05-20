class RoutesAPI {
  static String baseUrl = 'https://api.openrouteservice.org/v2/directions/foot-walking';
  static String apiKey = '5b3ce3597851110001cf624804f654c0a2364e688e3c4fd8949e70ce';

  getRouteUrl(String startPoint, String endPoint){
    return Uri.parse('$baseUrl?api_key=$apiKey&start=$startPoint&end=$endPoint');
  }
}