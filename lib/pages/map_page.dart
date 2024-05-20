import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mktrip/list/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mktrip/map/routes_api.dart';

class MapPage extends StatefulWidget {
  MapPage(this.selectedPlaces, {Key? key}) : super(key: key);
  final List<Place> selectedPlaces;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late Geolocator _geolocator;
  List<LatLng> points = [];
  List<List<LatLng>> routes = [];

  void updateLocation() async {}

  getCoordinates() async {
    Position newPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .timeout(new Duration(seconds: 5));
    var routesapi = RoutesAPI();
    String myPosition =
        '${newPosition.latitude.toString()},${newPosition.longitude.toString()}';
    var rList = widget.selectedPlaces
        .map((e) {
          var target = '${e.latitude.toString()},${e.longitude.toString()}';
          var response =
               http.get(routesapi.getRouteUrl(myPosition, target)).then((value) {
                 var data = jsonDecode(value.body);
                 var listOfPoints = data['features'][0]['geometry']['coordinates'];
                 var route = listOfPoints
                     .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
                     .toList();
                 myPosition = target;
                 return route;
               });
        })
        .cast<List<LatLng>>()
        .toList();

    print(rList);

    setState(() {
      routes = rList;
    });
  }

  final mapController = MapController();

  @override
  void initState() {
    super.initState();
    _geolocator = Geolocator();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = [];
    int markerNumber = 1;

    for (Place place in widget.selectedPlaces) {
      double latitude = 0.0;
      double longitude = 0.0;

      markers.add(
        Marker(
          width: 22.5,
          height: 22.5,
          point: LatLng(place.latitude, place.longitude),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Text(
                '$markerNumber',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ),
      );

      markerNumber++;
    }

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high);
              mapController.move(
                  LatLng(position.latitude, position.longitude), 14);
            },
            child: const Icon(Icons.my_location),
          ),
          SizedBox(
            height: 8,
          ),
          widget.selectedPlaces.length > 0
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back),
                )
              : SizedBox.shrink(),
          FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            onPressed: () => getCoordinates(),
            child: const Icon(
              Icons.route,
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(55.796127, 49.106414),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            maxZoom: 25,
          ),
          MarkerLayer(
            markers: markers,
          ),
          CurrentLocationLayer(
            alignPositionOnUpdate: AlignOnUpdate.never,
            alignDirectionOnUpdate: AlignOnUpdate.never,
            style: LocationMarkerStyle(
              marker: const DefaultLocationMarker(
                color: Colors.deepPurple,
                child: Icon(
                  Icons.navigation,
                  color: Colors.white,
                ),
              ),
              markerSize: const Size.square(33),
              accuracyCircleColor: Colors.purple.withOpacity(0.1),
              headingSectorColor: Colors.purple.withOpacity(0.8),
              headingSectorRadius: 60,
              markerDirection: MarkerDirection.heading,
            ),
          ),
          PolylineLayer(
              polylineCulling: false,
              polylines: routes
                  .map(
                    (e) => Polyline(
                        points: e, color: Colors.black, strokeWidth: 5),
                  )
                  .toList()),
        ],
      ),
    );
  }
}
