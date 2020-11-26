import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_u/people.dart';
import 'package:flutter/material.dart';

class Plan extends StatefulWidget {
  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SearchBar(),
            Row(
              children: <Widget>[
                Text('사람들'), // theme 추가
                ButtonTheme(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
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
//            _buildCards()
          ],
        ),
      )
    );
  }

  Widget _buildCards() {
    return Expanded(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("items").orderBy("price").snapshots(),
//            stream: items.item.orderBy("price", descending: isDescending).snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.hasError)
                return Text("Error: ${snapshot.error}");
              if(!snapshot.hasData)
                return LinearProgressIndicator();
              return GridView.count(
                  crossAxisCount: 1,
                  padding: EdgeInsets.all(16.0),
                  childAspectRatio: 8.0 / 9.0,
                  children: snapshot.data.docs.map((DocumentSnapshot data) {
                    var record = Record.fromSnapshot(data);
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AspectRatio(
                              aspectRatio: 18 / 11,
                              child:
                              Image.network(record.url)
//                                      child: record.url == "http://handong.edu/site/handong/res/img/logo.png"?
//                                      Image.network(record.url)
//                                          :
//                                      Image.file(
//                                        image,
//                                        width: 400,
//                                        height: 280,
//                                        fit: BoxFit.fitHeight,
//                                      ),


//                                        child: record.url != "http://handong.edu/site/handong/res/img/logo.png"?
//                                        Image.file(
//                                          image,
//                                          width: 400,
//                                          height: 280,
//                                          fit: BoxFit.fitHeight,
//                                        )
//                                            :
//                                        Image.network("http://handong.edu/site/handong/res/img/logo.png")
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    record.name,
//                                              data.data()['name'],
                                    style: theme.textTheme.headline6,
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    record.price.toString(),
                                    style: theme.textTheme.subtitle2,
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      SizedBox(width: 120),
                                      InkWell(
                                          child: Text(
                                            "more",
                                            style: TextStyle(fontSize: 12, color: Colors.indigo),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
//                                                          builder: (context) => DetailPage(data),
//                                                          builder: (context) => DetailPage(record:data),
                                                builder: (context) => DetailPage(record: record),
                                              ),
                                            );
                                          })
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
