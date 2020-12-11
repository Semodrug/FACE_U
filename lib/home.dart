import 'package:face_u/people.dart';
import 'package:face_u/plan.dart';
import 'package:flutter/material.dart';
import 'camera.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    PeoplePage(),
    Camera(),
    Plan()
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
        automaticallyImplyLeading: false,
          title: Text("Face U", style: Theme.of(context).textTheme.headline1),

      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt),
                label: 'camera'
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
