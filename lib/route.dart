import 'package:flutter/material.dart';

import 'camera.dart';
import 'login.dart';
import 'home.dart';
import 'detail.dart';
import 'add.dart';
//import 'plan.dart';
import 'recognition.dart';
import 'result.dart';

class FaceUApp extends StatelessWidget {
  Color color = const Color(0xffFFdb80);
  //final String doc_id = 'default';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shrine',
        home: HomePage(), //HomePage
//        initialRoute: '/login',
//        initialRoute: '/home',
        initialRoute: '/home',
        routes: {
          '/login': (context) => LogInPage(),
          '/home': (context) => HomePage(),
          '/add': (context) => AddPage(),
          '/recognition': (context) => Recognition(),
          //'/plan': (context) => Plan(),
          '/camera': (context) => Camera(),
          '/result': (context) => ResultPage(),
          //'/detail': (context) => Detail(doc_id),
        },
        theme: ThemeData(
          primaryColor: Color(0xffFFdb80),
          bottomAppBarColor: Color(0xffFFCB83),
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 20.0,
                fontFamily: 'OmniGothic',
                color: Colors.black87,
                fontWeight: FontWeight.bold), //apbar feature
            headline2: TextStyle(
                fontSize: 13.0,
                fontFamily: 'NotoSans',
                color: Colors.black87,
                fontWeight: FontWeight.bold),
//          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
//          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind',
//          color: Colors.black54),
            bodyText1: TextStyle(
              fontSize: 14.0,
              fontFamily: 'NotoSans',
              color: Colors.black54,
            ),
            bodyText2: TextStyle(
              fontSize: 12.0,
              fontFamily: 'NotoSans',
              color: Colors.black54,
            ),
          ),
        )
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
