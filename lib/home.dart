import 'package:flutter/material.dart';

import 'camera.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions =
      <Widget>[
        Text('Index 0: Home'),
//        Text('Index 1: Camera'),
        Text('Index 2: Plan'),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("FaceU", style: Theme.of(context).textTheme.headline1)
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_enhance),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(
                    builder: (context) => Camera()
              ));
        },
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'plan'
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).bottomAppBarColor,
        onTap: _onItemTapped
      ),

    );
  }
}
