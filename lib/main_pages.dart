import 'package:flutter/material.dart';
import 'package:mktrip/pages/home_page.dart';
import 'package:mktrip/pages/map_page.dart';
import 'package:mktrip/pages/places_page.dart';

class MainPages extends StatefulWidget {
  const MainPages({Key ?key});

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
        indicatorColor: Colors.deepPurple,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.place, color: Colors.white),
            icon: Icon(Icons.place),
            label: 'Places',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.map, color: Colors.white ),
            icon: Icon(Icons.map),
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