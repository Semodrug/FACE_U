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
  //list 개수만큼
  //TextEditingController _featureCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final person = Persons.fromSnapshot(widget.data);
    var i =0;

    _nameCon.text = person.name;
    _groupCon.text = person.group;
    _relationCon.text = person.relation;
    //list
    List<TextEditingController> _FCon = List.generate(person.features.length, (i) => TextEditingController());
    List<dynamic> list_features = [];
    Map<String,TextEditingController> _featuresCon = {};
    var textFields = <TextField>[];
    person.features.forEach((feat) {
      TextEditingController _fCon = new TextEditingController(text: feat);
      _featuresCon.putIfAbsent(feat, () => _fCon);
      _FCon[i] = _fCon;
      i = i +1;
      return textFields.add(TextField(controller: _fCon));
    });
    //print('LIST ==> ${_featuresCon[0].text}');

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
            //list
            _FCon.clear();
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('저장'),
            onPressed: () {
//              if (_nameCon.text.isNotEmpty) {
//                updateDoc(widget.data.id, _nameCon.text, _groupCon.text,
//                    _relationCon.text, person.image_url, person.features);
//              }
              if (_nameCon.text.isNotEmpty) {
                for (var i = 0; i < person.features.length; i++) {
                  list_features.add(new ListTile());
                  print(list_features);
                }


                updateDoc(widget.data.id, _nameCon.text, _groupCon.text,
                    _relationCon.text, person.image_url, list_features);
              }
              _nameCon.clear();
              _groupCon.clear();
              _relationCon.clear();
              _FCon.clear();


              Navigator.pop(context);
            },
          )
        ],
      ),
      body:


      Column(
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

                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:

                      List.generate(person.features.length, (index) {
                        //print(textFields[index]);
                        return
                          Column(children: [
                            TextField(
                              autofocus: true,
                              controller: _FCon[index],
                              decoration: InputDecoration(
                                  border: InputBorder.none, labelText: "특징"),
                              //'특징${index + 1} :  ${listOfFeatures[index]}',
                            ) ,
                            SizedBox(
                              height: 5,
                            ),
                          ]);
                      })


                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }


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
