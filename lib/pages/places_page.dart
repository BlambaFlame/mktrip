import 'package:flutter/material.dart';
import 'package:mktrip/list/place.dart';
import 'package:dio/dio.dart';

class PlacesPage extends StatefulWidget {
  const PlacesPage({super.key});

  @override
  State<PlacesPage> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  List<Place> places = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromYandexMapsAPI();
  }

  void fetchDataFromYandexMapsAPI() async {
    var dio = Dio();

    try {
      Response response = await dio.get('https://search-maps.yandex.ru/v1/?apikey=e00d3994-d774-451e-a64e-a58db505bfe9&text=%D0%B4%D0%BE%D1%81%D1%82%D0%BE%D0%BF%D1%80%D0%B8%D0%BC%D0%B5%D1%87%D0%B0%D1%82%D0%B5%D0%BB%D1%8C%D0%BD%D0%BE%D1%81%D1%82%D0%B8&lang=ru');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['features'];
        List<Place> newPlaces = data.map((item) {
          return Place(
            title: item['properties']['name'],
            latitude: item['geometry']['coordinates'][1],
            longitude: item['geometry']['coordinates'][0],
          );
        }).toList();

        setState(() {
          places = newPlaces;
        });
      } else {
        print("Ошибка: ${response.statusCode}");
      }
    } catch (e) {
      print("Ошибка при запросе: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: places.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: Checkbox(value: places[index].selected,
                onChanged: (bool? value) {
                  setState(() {
                    places[index].selected = value ?? false;
                  });
                },
                ),
              title: Column(
                children: [
                  Text(places[index].title),
                ],
              ),
              subtitle: Align(alignment: Alignment.center,
               child: Text(
                '${places[index].latitude}, ${places[index].longitude}',
                  textAlign: TextAlign.center,),
            ),
            ),
          );
        },
      ),
    );
  }
}
