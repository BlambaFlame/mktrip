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
  bool isButtonActive = false;

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
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          leading: Checkbox(
                            value: places[index].selected,
                            onChanged: (bool? value) {
                              setState(() {
                                places[index].selected = value ?? false;
                                isButtonActive = value ?? false;
                              });
                            },
                          ),
                          title: Column(
                            children: [
                              Text(places[index].title),
                            ],
                          ),
                          subtitle: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '${places[index].latitude}, ${places[index].longitude}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: places.length,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ElevatedButton(
                onPressed: isButtonActive ? () {} : null,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(70.0), // Указываем радиус закругления
                    ),
                  ),
                ),
                child: Icon(Icons.pin_drop),

              ),
            ),
          ),
        ],
      ),
    );
  }
}
