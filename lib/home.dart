import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final num = 32; // streambuilder 로 불러오기

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face U'),
      ),
      body: Column(
        children: [
          SearchBar(),
          _countDrowpdown(context, num),
          //ListView.builder(itemBuilder: null),
          ListCards('name', 'relationship'),
          SizedBox(
            height: 5,
          ),
          ListCards('name', 'relationship'),
          SizedBox(
            height: 5,
          ),
          ListCards('name', 'relationship'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        //onPressed: () => addMovies(),
        onPressed: () {
          print('move to add page');
        },
      ),
      //TODO: floating button presse 하면 Addpage

    );
  }

//TODO:사람 명수, Dropdown Query로 써서 이름순, 등록순 하는 법
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
//        DropdownButton(
//
//        )
      ],
    );
  }

//TODO: List View Card 로 불러줘도 될 듯

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
              hintStyle: TextStyle(fontSize: 13.0, color: Colors.grey),
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
              child: Text(
                '확인',
                style: TextStyle(fontSize: 13),
              ),
              onPressed: () {},
            ))
      ],
    );
  }
}

class ListCards extends StatefulWidget {
  final String name;
  final String relationship;

  const ListCards(
      this.name,
      this.relationship, {
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
                leading: Icon(Icons.image),
                title: Text("이름 : ${widget.name}"),
                subtitle: Text("관계 : ${widget.relationship}"),
              ),
            ],
          ),
        ));
  }
}
