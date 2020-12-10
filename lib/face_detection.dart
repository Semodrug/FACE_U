import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class FaceDetection extends StatefulWidget {
  @override
  _FaceDetectionState createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection> {
  File _image;
  final picker = ImagePicker();

  void getImage() async {
    final PickedFile picked =
        await picker.getImage(source: ImageSource.gallery);

    if (picked == null) return;
    setState(() {
      _image = File(picked.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    getImage();

    return Container();
  }
}
