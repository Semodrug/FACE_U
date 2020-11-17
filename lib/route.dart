import 'package:flutter/material.dart';

import 'login.dart';
import 'home.dart';

import 'add.dart';
import 'plan.dart';
import 'recognition.dart';


class FaceUApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shrine',
        home: HomePage(),//HomePage
        initialRoute: '/login',
        routes: {
          '/login': (context) => LogInPage(),
          '/home': (context) => HomePage(),
          '/add': (context) => AddPage(),
          '/recognition': (context) => Recognition(),
          '/plan': (context) => Plan(),


//          Profile.routeName: (context) =>
//              Profile(),

        }
      //onGenerateRoute: _getRoute,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LogInPage(),
      fullscreenDialog: true,
    );
  }
}
