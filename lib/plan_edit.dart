import 'package:flutter/material.dart';

class EditPlanPage extends StatefulWidget {
  @override
  EditPlanPageState createState() => EditPlanPageState();
}

class EditPlanPageState extends State<EditPlanPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("약속 등록하기", style: Theme.of(context).textTheme.headline1)
      ),

    );
  }
}
