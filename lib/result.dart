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
              Text("아래 리스트 중 유사성을 가진 사람이 있습니다.",
                  //TODO: theme 만들기
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              Text(
                "나의 사람 리스트 안에서 일치하는 사람을  확률적으로 보여드립니다.",
                textAlign: TextAlign.left,
              ),
              TabBar(tabs: [Tab(text: '1위'), Tab(text: '2위'), Tab(text: '3위')]),
              Container(
                height: 1000,
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TabBarView(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TODO: 적당한 theme 만들기, 여백 더 넣기
                      Text('이름: 김희선',
                          style: Theme.of(context).textTheme.headline2),
                      Text('관계: 교수님',
                          style: Theme.of(context).textTheme.headline2),
                      Text('그룹: 학교',
                          style: Theme.of(context).textTheme.headline2),
                      SizedBox(height: 10),
                      Text('특징1: 목소리가 하이톤이시다',
                          style: Theme.of(context).textTheme.headline2),
                      Text('특징2: 분홍색 계열 옷을 자주 입으신다',
                          style: Theme.of(context).textTheme.headline2),
                      Text('특징3: 누군가를 부를 때 ~~씨 라고 말하신다',
                          style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TODO: 적당한 theme 만들기, 여백 더 넣기
                      Text('이름: 김희선',
                          style: Theme.of(context).textTheme.headline2),
                      Text('관계: 교수님',
                          style: Theme.of(context).textTheme.headline2),
                      Text('그룹: 학교',
                          style: Theme.of(context).textTheme.headline2),
                      SizedBox(height: 10),
                      Text('특징1: 목소리가 하이톤이시다',
                          style: Theme.of(context).textTheme.headline2),
                      Text('특징2: 분홍색 계열 옷을 자주 입으신다',
                          style: Theme.of(context).textTheme.headline2),
                      Text('특징3: 누군가를 부를 때 ~~씨 라고 말하신다',
                          style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TODO: 적당한 theme 만들기, 여백 더 넣기
                      Text('이름: 김희선',
                          style: Theme.of(context).textTheme.headline2),
                      Text('관계: 교수님',
                          style: Theme.of(context).textTheme.headline2),
                      Text('그룹: 학교',
                          style: Theme.of(context).textTheme.headline2),
                      SizedBox(height: 10),
                      Text('특징1: 목소리가 하이톤이시다',
                          style: Theme.of(context).textTheme.headline2),
                      Text('특징2: 분홍색 계열 옷을 자주 입으신다',
                          style: Theme.of(context).textTheme.headline2),
                      Text('특징3: 누군가를 부를 때 ~~씨 라고 말하신다',
                          style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
