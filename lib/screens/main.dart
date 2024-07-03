import 'package:DemoApp/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:simple_floating_bottom_nav_bar/floating_bottom_nav_bar.dart';
import 'package:simple_floating_bottom_nav_bar/floating_item.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue, // Primary color
        hintColor: Colors.red, // Accent color

      ),
      child: MaterialApp(
        title: 'Bottom Tab Bar',
        home: BottomTabBar(),
      ),
    );
  }
}

class BottomTabBar extends StatefulWidget {
  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _currentIndex = 0;
  List<FloatingBottomNavItem> bottomNavItems = const [
    FloatingBottomNavItem(
      inactiveIcon: Icon(Icons.list),
      activeIcon: Icon(Icons.list),
      label: "Home",
    ),
    FloatingBottomNavItem(
      inactiveIcon: Icon(Icons.location_on),
      activeIcon: Icon(Icons.location_on),
      label: "Location",
    ),

  ];
  final List<Widget> _pages = [
    HomePage(),
    MapPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return FloatingBottomNavBar(
      pages: _pages,
      items: bottomNavItems,
      initialPageIndex: 0,
      backgroundColor: Colors.red,
      bottomPadding: 5,
      elevation: 0,
      radius: 50,
      width: 300,
      height: 65,
      selectedLabelStyle: TextStyle( fontFamily: 'Montserrat',),
      unselectedLabelStyle: TextStyle( fontFamily: 'Montserrat',),
    );

  }
}
