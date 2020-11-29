import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_u/people.dart';
import 'package:flutter/material.dart';

import 'demo.dart';
import 'plan_add.dart';
import 'plan_detail.dart';

class Plan extends StatefulWidget {
  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  Color purple2 = const Color(0xffF1E7FF);
  Color purple3 = const Color(0xffC5B0E1);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanAddPage(),
                ),
              );
            },
            child: Icon(Icons.add_circle, size: 40),
            backgroundColor: purple3
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SearchBar(),
              Row(
                children: <Widget>[
                  SizedBox(width:15),
                  Text('Plans'),// theme 추가
                  ButtonTheme(
                    minWidth: 10,
                    height: 22,
                    child: FlatButton(
                      child: Text(
                        "32",
                        style: TextStyle(color: Colors.teal[400], fontSize: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
              _buildCards()
            ],
          ),
        )
    );
  }



  Widget _buildCards() {
    return Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Users").doc("yey0811").collection("Plans").orderBy("place", descending: true).snapshots(),
//            stream: FirebaseFirestore.instance.collection("Users").orderBy("price").snapshots(),
//            stream: items.item.orderBy("price", descending: isDescending).snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.hasError)
                return Text("Error: ${snapshot.error}");
              if(!snapshot.hasData)
                return LinearProgressIndicator();
              return GridView.count(
                  crossAxisCount: 1,
                  padding: EdgeInsets.all(10.0),
                  childAspectRatio: 8.0 / 6.4,
                  children: snapshot.data.docs.map((DocumentSnapshot data) {
                    var record = Record.fromSnapshot(data);
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 0.5,horizontal: 5),
                                        decoration: BoxDecoration(
                                          color: purple2,
                                          borderRadius: BorderRadius.all(Radius.circular(5)),),
                                        child: Text(record.time.toDate().toString().substring(0,4) + "년 " +
                                            record.time.toDate().toString().substring(5,7)+ "월  " +
                                            record.time.toDate().toString().substring(8,11) + "일 " ,
                                            style: Theme.of(context).textTheme.bodyText1),
                                      ),
                                      SizedBox(width: 152),
                                      InkWell(
                                        child: Icon(Icons.create, size: 20, color:Colors.grey),
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(
//                                            builder: (context) => PlanDetailPage()
                                              builder: (context) => DateTimePicker()

                                          )) ;
                                        },
                                      ),
                                      SizedBox(width: 10),
                                      InkWell(
                                        child: Icon(Icons.delete_outline, size: 20, color:Colors.grey),
                                        onTap: () {

                                        },
                                      ),
//                                      IconButton(icon: Icon(Icons.create), iconSize: 20,),
//                                      IconButton(icon: Icon(Icons.delete_outline), iconSize: 20,),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Text("Time:     " + record.time.toDate().toString().substring(11,13) + "시  " +
                                      record.time.toDate().toString().substring(17,19) + "분  " ,
                                      style: Theme.of(context).textTheme.bodyText1),
                                  Text("Place:    " + record.place.toString(),
                                      style: Theme.of(context).textTheme.bodyText1),
                                  Text("Memo:  " + record.memo,maxLines: 1,
                                      style: Theme.of(context).textTheme.bodyText1),
                                  Text("With:  ",
                                      style: Theme.of(context).textTheme.bodyText1),
                                  SizedBox(height: 7.0),
                                  Row(
                                    children: [
                                      Container(
                                          height: 100,
                                          width: 150,
                                          child: Image.network('http://image.xportsnews.com/contents/images/upload/article/2016/1118/1479450841761653.jpg', fit: BoxFit.fitWidth,)
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Name: Eunyoung Yang"),
                                          Text("Relation: Family"),
                                          Text("Features: long hair"),
                                        ],
                                      )
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      SizedBox(width: 300),
//                                      InkWell(
//                                          child: Text(
//                                            "more",
//                                            style: TextStyle(fontSize: 12, color: Colors.indigo),
//                                          ),
//                                          onTap: () {
//                                            Navigator.push(
//                                              context,
//                                              MaterialPageRoute(
//                                                builder: (context) => PlanDetailPage(),
//                                              ),
//                                            );
//                                          })
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList()
              );
            }
        )
    );
  }
}




class Record {
  final DocumentReference reference;

  var time;
  final String place;
  final String memo;
  final String withWhom;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['time'] != null),
        assert(map['place'] != null),
        assert(map['memo'] != null),
        assert(map['withWhom'] != null),

        time = map['time'],
        place = map['place'],
        memo = map['memo'],
        withWhom = map['withWhom'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

}