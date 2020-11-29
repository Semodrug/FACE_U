import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'camera.dart';
import 'route.dart';

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  final num = 32; // streambuilder 로 불러오기
  String _filterOrSort = "이름순"; //추가
  Query query = FirebaseFirestore.instance.collection('product');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          print('move to add page');
          Navigator.pushNamed(context, '/add');
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
                  child: Text(
                    num.toString(),
                    style: TextStyle(color: Colors.teal[400], fontSize: 12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 220),
        DropdownButton<String>(
          value: _filterOrSort,
          icon: Icon(Icons.keyboard_arrow_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: Colors.grey,
          ),
          onChanged: (String _filterOrSort) async {
            await _onActionSelected(_filterOrSort);
          },

          items: <String>['이름순', '등록순']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          //);
        ),

      ],
    );
  }

  Widget _buildBody(BuildContext context){
    print("        _buildBody");

    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Persons').snapshots(),
        builder: (context, stream){
          if (!stream.hasData) return LinearProgressIndicator();

          return _buildList(context, stream.data.docs);
        }
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
    print("        _buildList");

    return   Column(
      children: [
        SearchBar(),
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

  Widget _buildListItem(BuildContext context, DocumentSnapshot data){
    print("        _buildListItem");

    final person = Persons.fromSnapshot(data);
    String docID = data.id;

    return ListCards(person.name, person.relation, person.image);
  }


//TODO: List View Card 로 불러줘도 될 듯
  void _onActionSelected(String value) async {
    if (value == "이름순") {
      WriteBatch batch = FirebaseFirestore.instance.batch();

      await query.get().then((querySnapshot) async {

        await batch.commit();

        setState(() {
          _filterOrSort = "이름순";
        });
      });
    } else {
      setState(() {
        _filterOrSort = value;
      });
    }
  }

}
class Persons {
  final String name;
  final String image;
  final List <dynamic> features;
  final String relation;
  final String group;

  final DocumentReference reference;

  Persons.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['image'] != null),
        assert(map['relation'] != null),
        assert(map['features'] != null),
        assert(map['group'] != null),
        name = map['name'],
        image = map['image'],
        features = map['features'],
        relation = map['relation'],
        group = map['group'];

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
//        SizedBox(
//          width: 10,
//        ),
        Container(
            margin: EdgeInsets.only(top: 11),
            height: 33,
            width: 60,
            child: FlatButton(
              child: Text(
                  '확인', style: Theme.of(context).textTheme.bodyText2             ),
              onPressed: () {},
            ))
      ],
    );
  }
}

class ListCards extends StatefulWidget {
  final String name;
  final String relationship;
  final String image;

  const ListCards(
      this.name,
      this.relationship,
      this.image, {
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
                  width:84,
                  height: 84,
                  child:
                  Image.network(widget.image),
                ),
                title: Text("이름 : ${widget.name}", style: Theme.of(context).textTheme.bodyText1),
                subtitle: Text("관계 : ${widget.relationship}", style: Theme.of(context).textTheme.bodyText2),
              ),
            ],
          ),
        ));
  }
}