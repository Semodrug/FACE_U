import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'people.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final String auth_id = _auth.currentUser.uid;



class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
        //print('       filter == ${_filter.text}');
      });
    });
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').doc(auth_id).collection('People').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<DocumentSnapshot> searchResults = [];
    for (DocumentSnapshot d in snapshot) {
      //print('       searchText == $_searchText');
      //print('D ==> ${d.data().toString()}');
      if (d.data().toString().contains(_searchText)) {
        searchResults.add(d);
      }
      else print('    RESULT Nothing     ');
    }
    return Expanded(
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children:
        searchResults.map((data) => _buildListItem(context, data)).toList(),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final person = Persons.fromSnapshot(data);
    String docID = data.id;
    //print(docID);

    return ListCards(person.name, person.relation, person.image, person.group, docID);
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
        ),
        body:  Container(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 7),
          child: Column(
            children: [
              //Padding(padding: EdgeInsets.all(30)),
              Container(
                width: 370,
                height: 45,
                //padding: EdgeInsets.only(top: 3,),
                margin: EdgeInsets.fromLTRB(0, 11, 0, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: TextField(
                          focusNode: focusNode,
                          style: TextStyle(fontSize: 15),
                          autofocus: true,
                          controller: _filter,
                          decoration: InputDecoration(
                              fillColor: Colors.white12,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 20,
                              ),
                              suffixIcon: focusNode.hasFocus
                                  ? IconButton(
                                icon: Icon(Icons.cancel, size: 20),
                                onPressed: () {
                                  setState(() {
                                    _filter.clear();
                                    _searchText = "";
                                  });
                                },
                              )
                                  : Container(),
                              hintText: '검색',
                              labelStyle: TextStyle(color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                  BorderSide(color: Colors.transparent)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                  BorderSide(color: Colors.transparent)),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                  BorderSide(color: Colors.transparent))),
                        )),
                    focusNode.hasFocus ? Expanded(child: FlatButton(child: Text('clear', style: TextStyle(fontSize: 13),),
                      onPressed: (){
                        setState(() {
                          _filter.clear();
                          _searchText = "";
                          focusNode.unfocus();
                        });
                      },),) :
                    Expanded(flex: 0, child: Container(),)
                  ],
                ),
              ),
              _buildBody(context)
            ],
          ),
        ),
      );

  }


}
