import 'package:flutter/material.dart';
import 'package:mktrip/pages/home_page.dart';
import 'package:mktrip/pages/map_page.dart';
import 'package:mktrip/pages/places_page.dart';

class MainPages extends StatefulWidget {
  const MainPages({super.key});

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MKTrip'),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.orange,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.place),
            icon: Icon(Icons.place_outlined),
            label: 'Places',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.map),
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
        ],
      ),
      body: <Widget>[
        const MyHomePage(),
        const PlacesPage(),
        const MapPage(),
      ][currentPageIndex],
    );
  }
}
