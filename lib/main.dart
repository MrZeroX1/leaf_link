import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:leaf_link/screens/planner_screen.dart';
import 'package:leaf_link/screens/plant_list_screen.dart';
import 'package:leaf_link/screens/search_screen.dart';
import 'package:floating_navbar/floating_navbar.dart';
import 'package:leaf_link/screens/PlantIdentifierScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Plant App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AppHome(),
    );
  }
}

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    planner_screen(),
    PlantListScreen(),
    SearchScreen(),
    PlantIdentifierScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FloatingNavBar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FloatingNavBar(
        resizeToAvoidBottomInset: false,
        color: Colors.white,
        selectedIconColor: Color.fromARGB(255, 50, 126, 134),
        unselectedIconColor: Color.fromARGB(255, 50, 126, 134),
        items: [
          FloatingNavBarItem(
              iconData: Icons.list, page: planner_screen(), title: 'Planner'),
          FloatingNavBarItem(
              iconData: Icons.spa, page: PlantListScreen(), title: 'Plan List'),
          FloatingNavBarItem(
              iconData: Icons.camera,
              page: PlantIdentifierScreen(),
              title: 'Identifier'),
          FloatingNavBarItem(
              iconData: Icons.search, page: SearchScreen(), title: 'Search'),
        ],
        horizontalPadding: 10.0,
        hapticFeedback: true,
        showTitle: true,
      ),
    );
  }
}
