import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'people.dart';
import 'update.dart';
import 'package:firebase_auth/firebase_auth.dart';


//임시
final FirebaseAuth _auth = FirebaseAuth.instance;
String DOCid = '';
//final String auth_id = _auth.currentUser.uid;

class Detail extends StatefulWidget {
  final String id;

  const Detail(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("FaceU", style: Theme.of(context).textTheme.headline1)),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(_auth.currentUser.uid)
            .collection('People')
            .doc(widget.id)
            .snapshots(),
        builder: (context, stream) {
          if (!stream.hasData) return LinearProgressIndicator();
          print(widget.id);
          return _buildListItem(context, stream.data);
        });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final person = Persons.fromSnapshot(data);
    String docID = data.id;
    DOCid = docID;
    List<dynamic> listOfFeatures = [];
    listOfFeatures = person.features;

    return Padding(
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
                        image: NetworkImage(person.image_url)))),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  child: Text(
                    '수정',
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Update(data),
                      ),
                    );
                  },
                  textColor: Colors.blue,
                ),
                //TODO: 삭제되었습니다 알림이 필요할까?
                FlatButton(
                  child: Text(
                    '삭제',
                  ),
                  //TODO: delete 할 때 The method '[]' was called on null. 이 에러뜨는 거 방지!! 어캐
                  onPressed: () {
                    //Navigator.pushNamed(context, '/home');
                    Navigator.pop(context);
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(auth_id)
                        .collection('People')
                        .doc(widget.id)
                        .delete();

                    num = num - 1;
                  },
                  textColor: Colors.blue,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '이름 :  ${person.name}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '그룹 :  ${person.group}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '관계 :  ${person.relation}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  '대표 물건 바코드:    ${person.barcode}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(listOfFeatures.length, (index) {
                      return
                        Column(children: [
                          Text(
                            '특징${index + 1} :  ${listOfFeatures[index]}',
                            style: Theme.of(context).textTheme.bodyText1,
                          ) ,
                          SizedBox(
                            height: 5,
                          ),
                        ]);
                    })),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            //for(i)
            //Text('features: ${widget.features[0]}',style: Theme.of(context).textTheme.bodyText1)
          ],
        ),
      ),
    );
  }
}
