import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  Color purple1 = const Color(0xffD9E1FF);
  Color blue1 = const Color(0xff4EACFE);
  Color pink1 = const Color(0xffFFC2BE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 360),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text("정확한 얼굴 인식을 위해서는 최소 10장 이상의\n사진이 필요합니다.",
              overflow: TextOverflow.clip,
              style: Theme.of(context).textTheme.bodyText1),
          ),
          SizedBox(height: 10),
          Divider(height: 1.6, color: Colors.black45,),
//                indent: 15, endIndent: 15),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 30),
              Column(
                children: [
                  CircleAvatar(radius: 25, backgroundColor: purple1,
                    child: Icon(Icons.photo, color: Colors.black38, size: 25)),
                  SizedBox(height: 3),
                  Text("앨범", style: Theme.of(context).textTheme.bodyText2, )
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  CircleAvatar(radius: 25, backgroundColor: pink1,
                      child: Icon(Icons.camera_alt, color: Colors.black38, size: 25)),
                  SizedBox(height: 3),
                  Text("카메라", style: Theme.of(context).textTheme.bodyText2, )
                ],
              ),
              SizedBox(width: 20),
            ],
          )
        ],
      )
    );
  }
}
