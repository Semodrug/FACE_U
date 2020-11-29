import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'people.dart';

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
          title: Text("FaceU", style: Theme.of(context).textTheme.headline1)
      ),
      body: _buildBody(context),
      //TODO: floating button presse 하면 Addpage
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance.collection('Persons').doc(widget.id).snapshots(),
        builder: (context, stream){
          if (!stream.hasData) return LinearProgressIndicator();
            print(widget.id);
          return _buildListItem(context, stream.data);
        }
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final person = Persons.fromSnapshot(data);
    String docID = data.id;

    return
      Padding(
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
                          image: NetworkImage(
                              person.image
                          )))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    child: Text(
                      '사진 수정?',
                    ),
                    onPressed: () => null,
                    textColor: Colors.blue,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // TODO: hint theme
              Text('이름 : ${person.name}'
                ,
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 5,
              ),
              Text('그룹 : ${person.group}'
                ,
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 5,
              ),

              Text('관계 : ${person.relation}'
                ,
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 5,
              ),
              //for(i)
              //Text('features: ${widget.features[0]}',style: Theme.of(context).textTheme.bodyText1)
            ],
          ),
        ),
      );
  }

}


