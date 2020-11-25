import 'package:face_u/route.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'route.dart';

Future<void> main() async {
  //TODO: firebase연결하고 나서 이거 다시 해야
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FaceUApp());
}

// TODO: theme, text, appbar, underbar
