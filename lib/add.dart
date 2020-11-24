import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _nameCtl = TextEditingController();
    TextEditingController _priceCtl = TextEditingController();
    TextEditingController _descriptionCtl = TextEditingController();
    TextEditingController _characterCtl = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          child: Text(
            '취소',
            maxLines: 1,
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/home');
            // Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        title: Text(
          '페이스 추가',
        ),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            child: Text(
              '완료',
              maxLines: 1,
              // TODO: controller의 내용이 차있으면 blue, 없으면 gray
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () async {
              // TODO: 완료되었다는 메세지와 함께 자동으로 home으로 가게끔

              // if (_image == null) {
              //   Scaffold.of(context).showSnackBar(
              //       SnackBar(content: Text('You can only do it once !!')));
              // } else {
              //   currentUrl = await uploadFile(_image);
              //   addProduct(currentUrl);
              //
              //   Navigator.pushReplacementNamed(context, '/home');
              // }
            },
          ),
        ],
      ),
      body: Padding(
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
                              "https://i.imgur.com/BoN9kdC.png")))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    child: Text(
                      '사진 추가',
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
              TextField(
                controller: _nameCtl,
                decoration: InputDecoration(
                  hintText: '이름을 입력해주세요',
                  // hintStyle: TextStyle(color: Colors.blue[700])
                ),
              ), // border: OutlineInputBorder()
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
