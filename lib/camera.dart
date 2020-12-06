import 'dart:io';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:face_u/face_detection.dart';
import 'package:face_u/barcode.dart';

CameraState pageState;

class Camera extends StatefulWidget {
  @override
  CameraState createState() {
    pageState = CameraState();
    return pageState;
  }
}

class CameraState extends State<Camera> {
  File _image;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _user;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String _profileImageURL = "";

  @override
  void initState() {
    super.initState();
    _prepareService();
  }

  void _prepareService() async {
    _user = await _firebaseAuth.currentUser;
  }

  void _uploadImageToStorage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);

    if (image == null) return;
    setState(() {
      _image = image;
    });

    Reference storageReference = _firebaseStorage.ref().child("profile");

    UploadTask storageUploadTask = storageReference.putFile(_image);

    String downloadURL = await storageReference.getDownloadURL();
    setState(() {
      _profileImageURL = downloadURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        SimpleDialogOption(
          child: Text('얼굴 인식하기'),
          onPressed: () {
            _uploadImageToStorage(ImageSource.camera);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FaceDetection(image: _image)));
          },
        ),
        SimpleDialogOption(
          child: Text('바코드 인식하기'),
          onPressed: () {
            _uploadImageToStorage(ImageSource.camera);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Barcode(image: _image)));
          },
        ),
        SimpleDialogOption(child: Text('취소'), onPressed: () {}),
      ],
    );
  }
}
