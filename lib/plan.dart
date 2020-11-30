import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'plan_add.dart';
import 'plan_edit.dart';

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
                  childAspectRatio: 8.0 / 6.8,
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
//                                          child: Text(record.date.toString())
                                        child: Text(record.date.toString() ,
                                            style: Theme.of(context).textTheme.bodyText1),
                                      ),
                                      SizedBox(width: 140),
                                      InkWell(
                                        child: Icon(Icons.create, size: 20, color:Colors.grey),
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => EditPlanPage()
                                          )) ;
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete_outline, size: 20, color:Colors.grey),
                                        onPressed: () {

                                          record.reference.delete();
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Text("Time:     " + record.time,
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

  final String date;
  final String time;
  final String place;
  final String memo;
  final String withWhom;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['date'] != null),
        assert(map['time'] != null),
        assert(map['place'] != null),
        assert(map['memo'] != null),
        assert(map['withWhom'] != null),

        date = map['date'],
        time = map['time'],
        place = map['place'],
        memo = map['memo'],
        withWhom = map['withWhom'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}



class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    //이 search bar에서 바로 검색을 하게 할 것인가?
    return Row(
      children: <Widget>[
        Container(
          width: 315,
          height: 33,
          padding: EdgeInsets.only(left: 20, right: 30),
          margin: EdgeInsets.fromLTRB(15, 11, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.grey[200],
          ),
          child: TextField(
            cursorColor: Colors.black,
            decoration: InputDecoration(
              icon: Icon(Icons.search, size: 20),
              hintText: "사람의 이름, 특징을 검색해보세요 ",
              //hintStyle: TextStyle(fontSize: 13.0, color: Colors.grey),
              hintStyle: Theme.of(context).textTheme.bodyText2,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
            margin: EdgeInsets.only(top: 11),
            height: 33,
            width: 55,
            child: FlatButton(
              child: Text('확인', style: Theme.of(context).textTheme.bodyText2),
              onPressed: () {},
            ))
      ],
    );
  }
}