import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Color purple1 = const Color(0xffD9E1FF);
  Color blue1 = const Color(0xff4EACFE);
  Color pink1 = const Color(0xffFFC2BE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
//          SizedBox(height: 360),
          Container(
              child: Image(image: (_image != null) ? FileImage(_image) : NetworkImage(""),),
            height: 330
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text("정확한 얼굴 인식을 위해서는 최소 10장 이상의\n사진이 필요합니다.",
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.bodyText1),
          ),
          SizedBox(height: 10),
          Divider(height: 1, color: Colors.black45,),
//                indent: 15, endIndent: 15),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 30),
              Column(
                children: [
                  InkWell(
                    child: CircleAvatar(radius: 25, backgroundColor: purple1,
                      child: Icon(Icons.photo, color: Colors.black38, size: 25)),
                    onTap: (){
                      _uploadImageToStorage(ImageSource.gallery);
                    },
                  ),
                  SizedBox(height: 3),
                  Text("앨범", style: Theme.of(context).textTheme.bodyText2, )
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  InkWell(
                    child: CircleAvatar(radius: 25, backgroundColor: pink1,
                        child: Icon(Icons.camera_alt, color: Colors.black38, size: 25)),
                    onTap: () {
                      _uploadImageToStorage(ImageSource.camera);
                    },
                  ),
                  SizedBox(height: 3),
                  Text("카메라", style: Theme.of(context).textTheme.bodyText2, )
                ],
              ),
              SizedBox(width: 20),
            ],
          )
        ],
      )
    );
  }


  void _uploadImageToStorage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);

    if (image == null) return;
    setState(() {
      _image = image;
    });

    Reference storageReference =
    _firebaseStorage.ref().child("profile");

    UploadTask storageUploadTask = storageReference.putFile(_image);

    String downloadURL = await storageReference.getDownloadURL();
    setState(() {
      _profileImageURL = downloadURL;
    });
  }
}
