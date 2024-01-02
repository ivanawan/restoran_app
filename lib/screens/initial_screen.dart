import 'package:flutter/material.dart';
import 'package:restoran_app/screens/my_home_page.dart';
import 'package:restoran_app/screens/search_screen.dart';

class initialScreen extends StatefulWidget{
  @override
  State<initialScreen> createState() =>_initialScreenState();
}

class _initialScreenState extends State<initialScreen>{
  int _selectedIndex = 0;
  static  final List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    Search()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlueAccent,
        onTap: _onItemTapped,
      ),
    );
  }

}