import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mktrip/map/domain/app_lat_long.dart';
import 'package:mktrip/map/domain/location_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';


class MapPage extends StatefulWidget {
  const MapPage({key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<YandexMapController> mapControllerCompleter = Completer();
  late final YandexMapController _mapController;
  CameraPosition? _userLocation;

  @override
  void initState() {
    super.initState();
    _initPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      body: YandexMap(
        onUserLocationAdded: (view) async{
          _userLocation = await _mapController.getUserCameraPosition();
          // если местоположение найдено, центрируем карту относительно этой точки
          if (_userLocation != null) {
            await _mapController.moveCamera(
              CameraUpdate.newCameraPosition(
                _userLocation!.copyWith(zoom: 10),
              ),
              animation: const MapAnimation(
                type: MapAnimationType.linear,
                duration: 0.3,
              ),
            );
          }
          return view.copyWith(
            pin: view.pin.copyWith(
              opacity: 1,
            ),
          );
        },
        onMapCreated: (controller) {
          _mapController = controller;
          mapControllerCompleter.complete(controller);
        },
      ),
    );
  }

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = MoscowLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }

    _moveToCurrentLocation(location);
  }

  Future<void> _moveToCurrentLocation(AppLatLong appLatLong) async {
    final controller = await mapControllerCompleter.future;

    // Move the camera to the user's current location
    controller.moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(latitude: appLatLong.lat, longitude: appLatLong.long),
          zoom: 16,
        ),
      ),
    );
  }
}
