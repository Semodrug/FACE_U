import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
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
//  File _image;
  File galleryImage;
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
      galleryImage = image;
    });

    Reference storageReference = _firebaseStorage.ref().child("profile");

    UploadTask storageUploadTask = storageReference.putFile(galleryImage);

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
            _uploadImageToStorage(ImageSource.gallery);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FaceDetection(image: galleryImage)));
          },
        ),
        SimpleDialogOption(
          child: Text('바코드 인식하기'),
          onPressed: () {
            _uploadImageToStorage(ImageSource.gallery);
            Navigator.push(
                context,
                MaterialPageRoute(
//                    builder: (context) => ReadBarcode(text: text)));
                    builder: (context) => ReadBarcode()));

          },
        ),
        SimpleDialogOption(child: Text('취소'), onPressed: () {}),
      ],
    );
  }
}
