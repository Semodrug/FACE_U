import 'package:flutter/material.dart';

import 'package:face_u/login.dart';

import 'package:face_u/home.dart';
import 'package:face_u/detail.dart';
import 'package:face_u/add.dart';

import 'package:face_u/camera.dart';
import 'package:face_u/barcode.dart';
import 'package:face_u/face_detection.dart';
import 'package:face_u/result.dart';

import 'package:face_u/plan.dart';

class FaceUApp extends StatelessWidget {
  Color color = const Color(0xffFFdb80);
  //final String doc_id = 'default';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FaceU',
        home: HomePage(), //HomePage
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),

          '/home': (context) => HomePage(),
          //'/detail': (context) => Detail(doc_id),
          '/add': (context) => AddPage(),

          '/camera': (context) => Camera(),
          '/face_detection': (context) => FaceDetection(),
          '/barcode': (context) => ReadBarcode(),
          '/result': (context) => ResultPage(),

          //'/plan': (context) => Plan(),
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
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}
