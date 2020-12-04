import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'people.dart';

class Update extends StatefulWidget {
  final DocumentSnapshot data;

  const Update(
    this.data, {
    Key key,
  }) : super(key: key);

  @override
  _UpdateState createState() {
    return _UpdateState();
  }
}

class _UpdateState extends State<Update> {
  TextEditingController _nameCon = TextEditingController();
  TextEditingController _groupCon = TextEditingController();
  TextEditingController _relationCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final person = Persons.fromSnapshot(widget.data);

    _nameCon.text = person.name;
    _groupCon.text = person.group;
    _relationCon.text = person.relation;

    return Scaffold(
      appBar: AppBar(
        title: new Center(child: new Text('Edit', textAlign: TextAlign.center)),
        leading: FlatButton(
          child: SizedBox(
            width: 100,
            child: Text('취소'),
          ),
          //TODO: 뒤로가기
          onPressed: () {
            _nameCon.clear();
            _groupCon.clear();
            _relationCon.clear();
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('저장'),
            onPressed: () {
              if (_nameCon.text.isNotEmpty) {
                updateDoc(widget.data.id, _nameCon.text, _groupCon.text,
                    _relationCon.text, person.image_url, person.features);
              }
              _nameCon.clear();
              _groupCon.clear();
              _relationCon.clear();

              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 100,
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 100,
                    child: Center(
                        child: Image(
                      image: NetworkImage(person.image_url),
                    )),
                  ),
                  TextField(
                    controller: _nameCon,
                    decoration: InputDecoration(labelText: "이름"),
                  ),
                  TextField(
                    autofocus: true,
                    controller: _groupCon,
                    decoration: InputDecoration(
                        border: InputBorder.none, labelText: "그룹"),
                  ),
                  TextField(
                    autofocus: true,
                    controller: _relationCon,
                    decoration: InputDecoration(
                        border: InputBorder.none, labelText: "관계"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //TODO: dialog가 아니라 하나의 새로운 페이지를 만들어야 한다.

  void updateDoc(String docID, String name, String group, String relation,
      String image, List<dynamic> features) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(auth_id)
        .collection('People')
        .doc(docID)
        .updateData({
      'name': name,
      'group': group,
      'relation': relation,
      'image': image,
      'features': features,
    });
  }
}
