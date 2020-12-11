import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

//import 'package:firebase_auth/firebase_auth.dart';
import 'people.dart';
import 'detail.dart';

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

  //add the feature
  TextEditingController _add2 = TextEditingController();
  bool secondFeature = false;

  List<dynamic> list_features = [];
  Map<String, TextEditingController> _featuresCon = {};
  var textFields = <TextField>[];

  @override
  Widget build(BuildContext context) {
    final person = Persons.fromSnapshot(widget.data);
    var i = 0;

    _nameCon.text = person.name;
    _groupCon.text = person.group;
    _relationCon.text = person.relation;
    //list
    List<TextEditingController> _FCon =
        List.generate(person.features.length, (i) => TextEditingController());

    person.features.forEach((feat) {
      TextEditingController _fCon = new TextEditingController(text: feat);
      _featuresCon.putIfAbsent(feat, () => _fCon);
      _FCon[i] = _fCon;
      i = i + 1;
      return textFields.add(TextField(controller: _fCon));
    });

    Future<void> addProduct() async {
      try {
        /* save text field data to "featureList" */
        //list_features.add(_add1.text);
        secondFeature ? list_features.add(_add2.text) : null;

        assert(list_features != null);

        print("saved successfully");
      } catch (e) {
        print('Error: $e');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: new Center(child: new Text('Edit', textAlign: TextAlign.center)),
        leading: InkWell(
          child:
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 15, 0, 0),
            child: Text(
                '취소'
            ),
          ),
          onTap: () {
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
                  print("     ");
                  print(person.features);
                  print("     ");

                  list_features.add(_FCon[i].text);
                }
                addProduct();

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
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 16.0),
          child: SingleChildScrollView(
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
                  style: Theme.of(context).textTheme.bodyText1,
                  controller: _nameCon,
                  decoration: InputDecoration(labelText: "이름"),
                ),
                TextField(
                  style: Theme.of(context).textTheme.bodyText1,
                  autofocus: true,
                  controller: _groupCon,
                  decoration: InputDecoration(labelText: "그룹"),
                ),
                TextField(
                  style: Theme.of(context).textTheme.bodyText1,
                  autofocus: true,
                  controller: _relationCon,
                  decoration: InputDecoration(labelText: "관계"),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(person.features.length, (index) {
                      var len = index + 1;
                      if (len != person.features.length) {
                        return Column(children: [
                          TextField(
                            style: Theme.of(context).textTheme.bodyText1,
                            autofocus: true,
                            controller: _FCon[index],
                            decoration: InputDecoration(labelText: "특징",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.lightGreen,
                                ),
                                onPressed: () {
                                      person.features.remove(person.features[index]);
                                      _FCon.remove(_FCon[index]);
//                                      print('check for _FCON ==> ${_FCon[index]}');
//                                      print(person.features);
//                                      print(person.features.length);
                                 },
                              ),),

                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ]);
                      } else {
                        return Column(children: [
                          TextField(
                            style: Theme.of(context).textTheme.bodyText1,
                            autofocus: true,
                            controller: _FCon[index],
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: secondFeature
                                  ? Icon(Icons.delete, color: Colors.lightGreen,)
                                  : Icon(Icons.add, color: Colors.lightGreen,),
                                  onPressed: () {
                                    if(secondFeature != true){
                                      setState(() {
                                        secondFeature = true;
                                      });
                                    }
                                    else{
                                      person.features.remove(person.features[index]);
                                      _FCon.remove(_FCon[index]);
                                    }
                                  },
                                ),
                                labelText: "특징"),
                            //'특징${index + 1} :  ${listOfFeatures[index]}',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ]);
                      }
                    })),
                secondFeature
                    ? TextField(
                        style: Theme.of(context).textTheme.bodyText1,
                        controller: _add2,
                        decoration: InputDecoration(
                            hintText: '특징을 입력해주세요',
                            hintStyle: TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.lightGreen,
                              ),
                            )),
                      )
                    : SizedBox(),
              ],
            ),
          )),
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
