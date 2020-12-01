import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

// 0. auth 먼저 하고
// 1. Firestore 와 연결 ==> error check 만 하면 된다!
// TODO: 2. image ==> 실버영과 이야기 해보기
// TODO: 3. + 버튼 누르면 더 적을 수 있게 칸이 바로바로 더 생겨야한다

// + 버튼을 만든다
// 눌러지면 바로바로 하나씩 더 만들어서 다시 그려줘야한다! --> setState

class _AddPageState extends State<AddPage> {
  File _image;
  // String currentUrl;
  // final picker = ImagePicker();
  // bool saved = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameCtl = TextEditingController();
    TextEditingController _relationCtl = TextEditingController();
    TextEditingController _groupCtl = TextEditingController();
    TextEditingController _featureCtl = TextEditingController();

    void addFeature() {}

    CollectionReference people = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser.uid)
        .collection('People');

    List<dynamic> emptyList = [];

    // Future<String> uploadFile(File file) async {
    //   String currUrl;
    //   //TODO: check error
    //
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

    //String currUrl

    Future<void> addProduct() async {
      try {
        assert(_nameCtl.text != null);
        assert(_relationCtl.text != null);
        // assert(_descriptionCtl.text != null);

        people.add({
          'name': _nameCtl.text,
          'relation': _relationCtl.text,
          'group': _groupCtl.text,
          'feature': _featureCtl.text,
          //'url': currUrl
        });

        print(
            "saved successfully: [${_nameCtl.text}-${_relationCtl.text}-${_groupCtl.text}]");

        // "saved successfully: [${_nameCtl.text}-${_relationCtl.text}-${_groupCtl.text}-$currUrl]");
      } catch (e) {
        print('Error: $e');
      }
    }

    // void getImage() async {
    //   final PickedFile picked =
    //       await picker.getImage(source: ImageSource.gallery);
    //
    //   if (picked == null) return;
    //   setState(() {
    //     _image = File(picked.path);
    //   });
    // }

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
              // TODO: controller의 내용이 차있으면 blue, 없으면 gray
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () async {
              // TODO: 완료되었다는 메세지와 함께 자동으로 home으로 가게끔

              // if (_image == null) {
              //   Scaffold.of(context).showSnackBar(
              //       SnackBar(content: Text('You can only do it once !!')));
              // } else {
              //currentUrl = await uploadFile(_image);
              addProduct();

              Navigator.pushReplacementNamed(context, '/home');
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
                              ? NetworkImage("https://i.imgur.com/BoN9kdC.png")
                              : FileImage(_image)))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    child: Text(
                      '사진 추가',
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/camera');
                    },
                    textColor: Colors.blue,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // TODO: hint theme
              TextField(
                controller: _nameCtl,
                decoration: InputDecoration(
                  hintText: '이름을 입력해주세요',
                  // hintStyle: TextStyle(color: Colors.blue[700])
                ),
              ), // border: OutlineInputBorder()
              TextField(
                controller: _relationCtl,
                decoration: InputDecoration(
                  hintText: '관계를 입력해주세요 (엄마, 대학친구, 상사 등)',
                  // hintStyle: TextStyle(color: Colors.blue[700])
                ),
              ),
              TextField(
                controller: _groupCtl,
                decoration: InputDecoration(
                  hintText: '소속을 입력해주세요 (가족, 친구, 직장 등)',
                  // hintStyle: TextStyle(color: Colors.blue[700])
                ),
              ),
              SizedBox(
                height: 20,
              ),

              TextField(
                onChanged: (text) {
                  // 현재 텍스트필드의 텍스트를 출력
                },
                controller: _featureCtl,
                decoration: InputDecoration(
                  hintText: '특징을 입력해주세요',
                  // hintStyle: TextStyle(color: Colors.blue[700])
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
