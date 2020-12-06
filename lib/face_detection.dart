import 'package:flutter/material.dart';
import 'dart:io';

class FaceDetection extends StatefulWidget {
  final File image;

  const FaceDetection({Key key, this.image}) : super(key: key);
  @override
  _FaceDetectionState createState() => _FaceDetectionState(image);
}

class _FaceDetectionState extends State<FaceDetection> {
  final File image;
  _FaceDetectionState(this.image);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
