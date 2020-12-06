import 'package:flutter/material.dart';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  File _image;
  String _profileImageURL;
  // final picker = ImagePicker();
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _nameCtl = TextEditingController();
  TextEditingController _relationCtl = TextEditingController();
  TextEditingController _groupCtl = TextEditingController();
  TextEditingController _featureCtl_1 = TextEditingController();
  TextEditingController _featureCtl_2 = TextEditingController();
  TextEditingController _featureCtl_3 = TextEditingController();
  TextEditingController _featureCtl_4 = TextEditingController();

  bool secondFeature = false;
  bool thirdFeature = false;
  bool fourthFeature = false;
  bool isFilled = false;

  List<dynamic> featureList = [];

  @override
  Widget build(BuildContext context) {
    CollectionReference people = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser.uid)
        .collection('People');

    // isFilled = _nameCtl.text.isNotEmpty &&
    //     _relationCtl.text.isNotEmpty &&
    //     _groupCtl.text.isNotEmpty &&
    //     _featureCtl_1.text.isNotEmpty;

    /* Pick image */
    // void getImage() async {
    //   final PickedFile picked =
    //       await picker.getImage(source: ImageSource.gallery);
    //
    //   if (picked == null) return;
    //   setState(() {
    //     _image = File(picked.path);
    //   });
    // }

    /* Upload picked image to firestore and Get image URL*/
    // Future<String> uploadFile(File file) async {
    //   String currUrl;
    //   Reference imageRef = FirebaseStorage.instance.ref().child(_nameCtl.text);
    //
    //   //UploadTask currentTask = await imageRef.putFile(file);
    //   UploadTask currentTask = imageRef.putFile(file);
    //
    //   print("saved successfully: [image from image picker]");
    //
    //   await currentTask.whenComplete(() async {
    //     currUrl = await imageRef.getDownloadURL();
    //
    //     saved = true;
    //
    //     return currUrl;
    //   });
    // }

    /* Pick image and Upload picked image to firestore and Get image URL */
    void _uploadImageToStorage(ImageSource source) async {
      File image = await ImagePicker.pickImage(source: source);

      if (image == null) return;

      setState(() {
        _image = image;
      });

      Reference storageReference =
          FirebaseStorage.instance.ref().child("profile");

      UploadTask storageUploadTask = storageReference.putFile(_image);

      String downloadURL = await storageReference.getDownloadURL();
      setState(() {
        _profileImageURL = downloadURL;
      });
    }

    Future<void> addProduct() async {
      try {
        assert(_nameCtl.text != null);
        assert(_relationCtl.text != null);
        assert(_groupCtl.text != null);

        /* save text field data to "featureList" */
        featureList.add(_featureCtl_1.text);
        secondFeature ? featureList.add(_featureCtl_2.text) : null;
        thirdFeature ? featureList.add(_featureCtl_3.text) : null;
        fourthFeature ? featureList.add(_featureCtl_4.text) : null;

        assert(featureList != null);

        people.add({
          'name': _nameCtl.text,
          'relation': _relationCtl.text,
          'group': _groupCtl.text,
          'features': featureList,
          'image_url': _profileImageURL
        });

        print(
            // "saved successfully: [${_nameCtl.text}-${_relationCtl.text}-${_groupCtl.text}]");
            "saved successfully: [${_nameCtl.text}-${_relationCtl.text}-${_groupCtl.text}-$_profileImageURL]");
      } catch (e) {
        print('Error: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          child: Text(
            '취소',
            maxLines: 1,
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/home');
            // Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        title: Text(
          '페이스 추가',
        ),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            child: Text(
              '완료',
              maxLines: 1,
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () async {
              // TODO: 완료되었다는 메세지와 함께 자동으로 home으로 가게끔

              if (_image == null) {
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('사진을 추가해주세요!')));
              } else {
                addProduct();

                Navigator.pushReplacementNamed(context, '/home');
              }
              //}
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 25,
              ),
              Container(
                  width: 135.0,
                  height: 135.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: _image == null
                              ? NetworkImage(
                                  "https://png.pngitem.com/pimgs/s/105-1050694_user-placeholder-image-png-transparent-png.png")
                              : FileImage(_image)))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    child: Text(
                      '사진 추가',
                    ),
                    onPressed: () {
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              title: Text(
                                '사진 추가',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              children: <Widget>[
                                SimpleDialogOption(
                                  child: Text('사진 촬영하기'),
                                  onPressed: () {
                                    _uploadImageToStorage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                ),
                                SimpleDialogOption(
                                  child: Text('갤러리에서 고르기'),
                                  onPressed: () {
                                    _uploadImageToStorage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                ),
                                SimpleDialogOption(
                                  child: Text('취소'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                      ;
                      // Navigator.pushNamed(context, '/camera');
                    },
                    textColor: Colors.blue,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // TODO: hint theme with 은영
              TextField(
                controller: _nameCtl,
                decoration: InputDecoration(
                    hintText: '이름을 입력해주세요',
                    hintStyle: TextStyle(color: Colors.grey)),
              ), // border: OutlineInputBorder()
              TextField(
                controller: _relationCtl,
                decoration: InputDecoration(
                    hintText: '관계를 입력해주세요 (엄마, 친구, 상사 등)',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
              TextField(
                controller: _groupCtl,
                decoration: InputDecoration(
                    hintText: '소속을 입력해주세요 (가족, 학교, 직장 등)',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
              SizedBox(
                height: 20,
              ),

              /* Features */

              TextField(
                controller: _featureCtl_1,
                decoration: InputDecoration(
                    hintText: '특징을 입력해주세요',
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.lightGreen,
                      ),
                      onPressed: () {
                        setState(() {
                          secondFeature = true;
                          print(secondFeature);
                        });
                      },
                    )),
              ),
              secondFeature
                  ? TextField(
                      controller: _featureCtl_2,
                      decoration: InputDecoration(
                          hintText: '특징을 입력해주세요',
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.lightGreen,
                            ),
                            onPressed: () {
                              setState(() {
                                thirdFeature = true;
                                print(thirdFeature);
                              });
                            },
                          )),
                    )
                  : SizedBox(),
              thirdFeature
                  ? TextField(
                      controller: _featureCtl_3,
                      decoration: InputDecoration(
                          hintText: '특징을 입력해주세요',
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.lightGreen,
                            ),
                            onPressed: () {
                              setState(() {
                                fourthFeature = true;
                                print(fourthFeature);
                              });
                            },
                          )),
                    )
                  : SizedBox(),
              fourthFeature
                  ? TextField(
                      controller: _featureCtl_4,
                      decoration: InputDecoration(
                        hintText: '특징을 입력해주세요',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
