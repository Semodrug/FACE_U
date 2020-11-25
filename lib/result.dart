import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            title: Text("인식결과", style: Theme.of(context).textTheme.headline1)),
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   leading: TextButton(
        //     child: Text(
        //       '취소',
        //       maxLines: 1,
        //       style: TextStyle(color: Colors.black, fontSize: 12),
        //     ),
        //     onPressed: () {
        //       Navigator.pop(context);
        //       // Navigator.pushNamed(context, '/home');
        //       // Navigator.pushReplacementNamed(context, '/home');
        //     },
        //   ),
        //   title: Text(
        //     '페이스 추가',
        //   ),
        //   centerTitle: true,
        //   actions: <Widget>[
        //     TextButton(
        //       child: Text(
        //         '완료',
        //         maxLines: 1,
        //         // TODO: controller의 내용이 차있으면 blue, 없으면 gray
        //         style: TextStyle(color: Colors.blue),
        //       ),
        //       onPressed: () async {
        //         // TODO: 완료되었다는 메세지와 함께 자동으로 home으로 가게끔
        //
        //         // if (_image == null) {
        //         //   Scaffold.of(context).showSnackBar(
        //         //       SnackBar(content: Text('You can only do it once !!')));
        //         // } else {
        //         //   currentUrl = await uploadFile(_image);
        //         //   addProduct(currentUrl);
        //         //
        //         //   Navigator.pushReplacementNamed(context, '/home');
        //         // }
        //       },
        //     ),
        //   ],
        // ),
        // body: Padding(
        //   padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 16.0),
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         SizedBox(
        //           height: 25,
        //         ),
        //         Container(
        //             width: 135.0,
        //             height: 135.0,
        //             decoration: BoxDecoration(
        //                 shape: BoxShape.circle,
        //                 image: DecorationImage(
        //                     fit: BoxFit.fill,
        //                     image: NetworkImage(
        //                         "https://i.imgur.com/BoN9kdC.png")))),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             FlatButton(
        //               child: Text(
        //                 '사진 추가',
        //               ),
        //               onPressed: () => null,
        //               textColor: Colors.blue,
        //             ),
        //           ],
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         // TODO: hint theme
        //         TextField(
        //           controller: _nameCtl,
        //           decoration: InputDecoration(
        //             hintText: '이름을 입력해주세요',
        //             // hintStyle: TextStyle(color: Colors.blue[700])
        //           ),
        //         ), // border: OutlineInputBorder()
        //         TextField(
        //           controller: _priceCtl,
        //           decoration: InputDecoration(
        //             hintText: '소속을 입력해주세요 (가족, 친구, 직장 등)',
        //             // hintStyle: TextStyle(color: Colors.blue[700])
        //           ),
        //         ),
        //         TextField(
        //           controller: _descriptionCtl,
        //           decoration: InputDecoration(
        //             hintText: '관계를 입력해주세요 (엄마, 대학친구, 상사 등)',
        //             // hintStyle: TextStyle(color: Colors.blue[700])
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         TextField(
        //           controller: _characterCtl,
        //           decoration: InputDecoration(
        //             hintText: '특징을 입력해주세요',
        //             // hintStyle: TextStyle(color: Colors.blue[700])
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      width: 450.0,
                      height: 180.0,
                      decoration: BoxDecoration(color: Colors.grey)),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                            width: 135.0,
                            height: 135.0,
                            decoration: BoxDecoration(
                                // color: Colors.grey,

                                // shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        "https://i.imgur.com/BoN9kdC.png")))),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // TODO: hint theme

              Text("아래 리스트 중 유사성을 가진 사람이 있습니다."),
              Text("나의 사람 리스트 안에서 일치하는 사람을  확률적으로 보여드립니다."),

              TabBar(tabs: [Tab(text: '1위'), Tab(text: '2위'), Tab(text: '3위')]),
              // TabBarView(children: [
              //   Icon(Icons.directions_car),
              //   Icon(Icons.directions_transit),
              //   Icon(Icons.directions_bike)
              // ])
              /*
              TextField(
                controller: _priceCtl,
                decoration: InputDecoration(
                  hintText: '소속을 입력해주세요 (가족, 친구, 직장 등)',
                  // hintStyle: TextStyle(color: Colors.blue[700])
                ),
              ),
              TextField(
                controller: _descriptionCtl,
                decoration: InputDecoration(
                  hintText: '관계를 입력해주세요 (엄마, 대학친구, 상사 등)',
                  // hintStyle: TextStyle(color: Colors.blue[700])
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _characterCtl,
                decoration: InputDecoration(
                  hintText: '특징을 입력해주세요',
                  // hintStyle: TextStyle(color: Colors.blue[700])
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
