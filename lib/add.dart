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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          '페이스 추',
        ),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            child: Text(
              '완료',
              maxLines: 1,
              // TODO: controller의 내용이 차있으면 색깔 다르게
              style: TextStyle(color: Colors.white),
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
              AspectRatio(
                  aspectRatio: 18 / 11,
                  child: Image.network(
                      'http://handong.edu/site/handong/res/img/logo.png')
                  //Image.file(image),
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // getImage();
                      }),
                ],
              ),
              TextField(
                controller: _nameCtl,
                decoration: InputDecoration(
                    hintText: 'Product Name',
                    hintStyle: TextStyle(color: Colors.blue[700])),
              ), // border: OutlineInputBorder()
              TextField(
                controller: _priceCtl,
                decoration: InputDecoration(
                    hintText: 'Price',
                    hintStyle: TextStyle(color: Colors.blue[700])),
              ),
              TextField(
                controller: _descriptionCtl,
                decoration: InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.blue[700])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
