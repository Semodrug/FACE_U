import 'package:firebase_ml_vision/firebase_ml_vision.dart';
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
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _nameCtl = TextEditingController();
  TextEditingController _relationCtl = TextEditingController();
  TextEditingController _groupCtl = TextEditingController();
  TextEditingController _featureCtl_1 = TextEditingController();
  TextEditingController _featureCtl_2 = TextEditingController();
  TextEditingController _featureCtl_3 = TextEditingController();
  TextEditingController _featureCtl_4 = TextEditingController();
  TextEditingController _barcodeCtl = TextEditingController();

  bool secondFeature = false;
  bool thirdFeature = false;
  bool fourthFeature = false;
  bool isFilled = false;

  List<dynamic> featureList = [];
  File pickedImage;
  var text = '';
  bool imageLoaded = false;

  TextEditingController getText() {
    setState((){
      _barcodeCtl.text = text;
    });
    return _barcodeCtl;
  }

  Future pickImage() async {
    var awaitImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = awaitImage;
      imageLoaded = true;

    });

    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(pickedImage);
    VisionText readedText;

    final BarcodeDetector barcodeDetector =
        FirebaseVision.instance.barcodeDetector();

    final List<Barcode> barcodes =
        await barcodeDetector.detectInImage(visionImage);

    for (Barcode barcode in barcodes) {
      final String rawValue = barcode.rawValue;
      final BarcodeValueType valueType = barcode.valueType;

      setState(() {
        text = "$rawValue";
      });
    }
    barcodeDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference people = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser.uid)
        .collection('People');

    void _getImage(ImageSource source) async {
      final PickedFile picked = await ImagePicker().getImage(source: source);

      if (picked == null) return;
      setState(() {
        _image = File(picked.path);
      });
    }

    /* Upload picked image to firestore and Get image URL*/
    Future<void> _uploadFile(File file) async {
      String currUrl;
      Reference imageRef = FirebaseStorage.instance.ref().child(_nameCtl.text);

      //UploadTask currentTask = await imageRef.putFile(file);
      UploadTask currentTask = imageRef.putFile(file);

      print("saved successfully: [image from image picker]");

      await currentTask.whenComplete(() async {
        String downloadURL = await imageRef.getDownloadURL();
        setState(() {
          _profileImageURL = downloadURL;
        });
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
          'image_url': _profileImageURL,
          'barcode': _barcodeCtl.text
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
                await _uploadFile(_image);
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
                                  "https://images.ctfassets.net/ww1ie0z745y7/3TDIeiOeNWUX7WupIfbRy/e25acfb5d2a2a09ea7da7c64a247b9e0/anonymous-unknown-headshot-circle-icon.jpg")
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
                                    _getImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                ),
                                SimpleDialogOption(
                                  child: Text('갤러리에서 고르기'),
                                  onPressed: () {
                                    _getImage(ImageSource.gallery);
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
                style: Theme.of(context).textTheme.bodyText1,
                controller: _nameCtl,
                decoration: InputDecoration(
                    hintText: '이름을 입력해주세요',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    )),
                //hintStyle: TextStyle( style: Theme.of(context).textTheme.bodyText2)
              ), // border: OutlineInputBorder()
              TextField(
                style: Theme.of(context).textTheme.bodyText1,
                controller: _relationCtl,
                decoration: InputDecoration(
                    hintText: '관계를 입력해주세요 (엄마, 친구, 상사 등)',
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
              TextField(
                style: Theme.of(context).textTheme.bodyText1,
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
                style: Theme.of(context).textTheme.bodyText1,
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
                      style: Theme.of(context).textTheme.bodyText1,
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
                      style: Theme.of(context).textTheme.bodyText1,
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
                      style: Theme.of(context).textTheme.bodyText1,
                      controller: _featureCtl_4,
                      decoration: InputDecoration(
                        hintText: '특징을 입력해주세요',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                height: 20,
              ),
              TextField(
                style: Theme.of(context).textTheme.bodyText1,
//                controller: _barcodeCtl,
                controller: getText(),
                decoration: InputDecoration(
                    hintText: '바코드를 등록하세요',
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.lightGreen,
                      ),
                      onPressed: () async {
                        pickImage();
//                        setState(() {
//                        _barcodeCtl.text = text;
//                        });

                      },

                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
