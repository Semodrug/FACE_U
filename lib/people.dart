import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_u/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'detail.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final String auth_id = _auth.currentUser.uid;

int num ; // streambuilder 로 불러오기

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  String _filterOrSort = "이름순";

  @override
  Widget build(BuildContext context) {
    ///sumi
    Query query = FirebaseFirestore.instance
        .collection('Users')
        .doc(_auth.currentUser.uid)
        .collection('People');


    switch (_filterOrSort) {
      case "이름순":
        query = query.orderBy('name', descending: false);
        break;

      case "그룹순":
        query = query.orderBy('group', descending: false);
        break;
    }

    Stream<QuerySnapshot> data = query.snapshots();

    Future totalNum() async {
      var querySnapshot = await query.getDocuments();
      var totalEquals = querySnapshot.docs.length;

      num = totalEquals;
      return totalEquals;
    }
    totalNum();

    return Scaffold(
      body: _buildBody(context, data),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
          //countDocuments();
        },
      ),
      //TODO: floating button presse 하면 Addpage
    );
  }

  Widget _countDrowpdown(context, num) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 19, top: 6),
          child: Row(
            children: <Widget>[
              Text('사람들'), // theme 추가
              ButtonTheme(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                minWidth: 10,
                height: 22,
                child: FlatButton(
                  //TODO: login으로 그냥 임의로 가기 위해 만들어 놓은 것 나중에 지우자!!
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    num.toString(),
                    //num,
                    style: TextStyle(color: Colors.teal[400], fontSize: 12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 220),
        /*
        DropdownButton (
          value: _selectedValue,
          items: _valueList.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String value) {
            setState(() {
              _selectedValue = value;
              isDescending = !isDescending;
            });
          },
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black87),
          iconEnabledColor: Colors.grey,
        ),
        */
        ///sumi
        DropdownButton<String>(
          value: _filterOrSort,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black),
          underline: Container(
            height: 1,
            color: Colors.black12,
          ),
          onChanged: (String newValue) {
            setState(() {
              _filterOrSort = newValue;
            });
          },
          items: <String>['이름순', '그룹순']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value.toUpperCase()),
            );
          }).toList(),
        ),

        ///
      ],
    );
  }

  Widget _buildBody(BuildContext context, Stream<QuerySnapshot> data) {
    return StreamBuilder<QuerySnapshot>(
      //stream: Firestore.instance.collection('Persons').snapshots(),
      ///sumi
        stream: data,
        //stream: person_data.orderBy('name', descending: isDescending).snapshots(),
        builder: (context, stream) {
          if (!stream.hasData) return LinearProgressIndicator();

          return _buildList(context, stream.data.docs);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    /*
    List<DocumentSnapshot> searchResults = [];
    for(DocumentSnapshot d in snapshot){
      if(d.data.toString().contains(_searchText)){
        searchResults.add(d);
      }
    }
*/
    return Column(
      children: [
        SearchBar(),
        //SearchScreen(),
        _countDrowpdown(context, num),
        //ListCards('name', 'relationship'),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children:
            snapshot.map((data) => _buildListItem(context, data)).toList(),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final person = Persons.fromSnapshot(data);
    String docID = data.id;

    return ListCards(
        person.name, person.relation, person.image_url, person.group, docID);
  }

}

class Persons {
  final String name;
  final String image_url;
  final List<dynamic> features;
  final String relation;
  final String group;
  final String barcode;

  final DocumentReference reference;

  Persons.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['relation'] != null),
        assert(map['group'] != null),
        name = map['name'],
        image_url = map['image_url'],
        features = map['features'],
        relation = map['relation'],
        group = map['group'],
        barcode = map['barcode'];

  Persons.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

//@override
//String toString() => "Record<$name:$like:$price:$explain:$image>";
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
          margin: EdgeInsets.fromLTRB(12, 11, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.grey[200],
          ),
          child: TextField(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SearchScreen(),
                ),
              );
            },
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
          width: 10,
        ),
        Container(
            margin: EdgeInsets.only(top: 11),
            height: 33,
            width: 65,
            child: FlatButton(
              child: Text('확인', style: Theme.of(context).textTheme.bodyText2),
              onPressed: () {},
            ))
      ],
    );
  }
}

class ListCards extends StatefulWidget {
  final String name;
  final String relationship;
  final String image_url;
  final String group;
  final String id;

  const ListCards(
      this.name,
      this.relationship,
      this.image_url,
      this.group,
      this.id, {
        Key key,
      }) : super(key: key);

  @override
  _ListCardsState createState() => _ListCardsState();
}

class _ListCardsState extends State<ListCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 390,
        height: 110,
        child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Container(
                    width: 84,
                    height: 84,
                    child: Image.network(widget.image_url),
                  ),
                  title: Text("이름 : ${widget.name}",
                      style: Theme.of(context).textTheme.bodyText1),
                  subtitle: Text(
                      "관계 : ${widget.relationship}" + '\n' + '그룹 : ${widget.group}',
                      style: Theme.of(context).textTheme.bodyText2),
                  trailing:                 //TODO: 삭제되었습니다 알림이 필요할까?
                  IconButton(
                    icon: Icon(Icons.delete),
                    //TODO: delete 할 때 The method '[]' was called on null. 이 에러뜨는 거 방지!! 어캐
                    onPressed: () {
                      //Navigator.pushNamed(context, '/home');
                      FirebaseFirestore.instance
                          .collection('Users')
                          .doc(auth_id)
                          .collection('People')
                          .doc(widget.id)
                          .delete();

                      Navigator.pop(context);

                      num = num - 1;
                    },
                    //textColor: Colors.blue,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Detail(widget.id),
                      ),
                    );

                  },
                )
              ],
            )));
  }
}
