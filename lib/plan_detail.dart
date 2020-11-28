import 'package:flutter/material.dart';

class PlanDetailPage extends StatefulWidget {
  @override
  _PlanDetailPageState createState() => _PlanDetailPageState();
}

class _PlanDetailPageState extends State<PlanDetailPage> {
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
