import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

import 'plan.dart';

class EditPlanPage extends StatefulWidget {
  String id;
  EditPlanPage(this.id, {Key key}) : super(key: key);

  @override
  _EditPlanPageState createState() => _EditPlanPageState();
}

class _EditPlanPageState extends State<EditPlanPage> {
  Color purple2 = const Color(0xffF1E7FF);
  Color purple3 = const Color(0xffC5B0E1);
  DateTime _checkInTime;
  String _selectedTime;
  TextEditingController _memoCtr = TextEditingController();
  TextEditingController _placeCtr = TextEditingController();
  TextEditingController _withCtr = TextEditingController();

  double _height;
  double _width;
  String _setTime, _setDate, setWith;
  String _hour, _minute, _time;
  String dateTime;
  DateTime date, time;
//  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  DateTime selectedDate =  DateTime(2019, 08, 1);
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

//  FirebaseFirestore.instance.collection("Users").doc(authId).collection("Plans")
//  FirebaseFirestore.instance.CollectionReference("Users").Doc

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        date = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
        //_dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
//        time = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        time = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]) as DateTime;
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMd().format(DateTime.now());


    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection("Users").doc(authId).collection("Plans").doc(id).snapshots(),
        builder: (context, stream){
          if (!stream.hasData)
            return LinearProgressIndicator();
          return editPlan(context, stream.data);
        }
    );

  }

  Widget editPlan(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    return Scaffold(
          appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text("약속 등록하기", style: Theme.of(context).textTheme.headline1),
              actions: <Widget> [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                  width: 70,
                  height: 20,
                  child: InkWell(
                      child: Text("완료", style: TextStyle(fontSize: 18)),
                      onTap: () {
                        record.reference.update({
//                          'date': selectedDate == null ? record.date : DateFormat.yMd().format(selectedDate) ,
                          'date': DateFormat.yMd().format(selectedDate),
                          'time': formatDate(
                              DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
                              [hh, ':', nn, " ", am]),
                          'place': _placeCtr.text,
                          'memo': _memoCtr.text,
                          'withWhom': _withCtr.text
                        });
                        Navigator.pop(context);
                      }
                  ),
                )
              ]
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 45,),
                  Row(
                    children: [
                      Text("Date",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black87,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5)),
                      SizedBox(width: 90),
                      Container(
                        width: _width / 3.3,
                        height: _height / 15.5,
                        child: TextFormField(
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _dateController,
                          onSaved: (String val) {
                            _setDate = val;
                          },
                          decoration: InputDecoration(
                              disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.only(top: 0.0)),
                        ),
                      ),
                      SizedBox(width: 10),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        color: purple3,
                        onPressed: (){
                          _selectDate(context);
                        },
                        child: Text('select date',),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text("Time",
//                    style: Theme.of(context).textTheme.headline1,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
//                        fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5),),
                      SizedBox(width: 85),
                      Container(
                        width: _width / 3.3,
                        height: _height / 15.5,
                        child: TextFormField(
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          onSaved: (String val) {
                            _setTime = val;
                          },
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: _timeController,
                          decoration: InputDecoration(
                              disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                              contentPadding: EdgeInsets.all(5)),
                        ),
                      ),
                      SizedBox(width: 10),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        color: purple3,
                        onPressed: (){
                          _selectTime(context);
                        },
                        child: Text('select time',),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text("Memo",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black87,
//                        fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5)),
                  TextField(
                    controller: _memoCtr,
                    decoration: InputDecoration(
                      hintText: '메모를 등록해주세요',
                    ),
                  ),
                  SizedBox(height: 30),
                  Text("Place",
//                    style: Theme.of(context).textTheme.headline1,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black87,
//                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5),),
                  TextField(
                    controller: _placeCtr,
                    decoration: InputDecoration(
                      hintText: '장소를 등록해주세요',
                      // hintStyle: TextStyle(color: Colors.blue[700])
                    ),
                  ),
                  SizedBox(height: 30),
                  Text("With",
//                    style: Theme.of(context).textTheme.headline1,
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black87,
//                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5),),
                  TextFormField(
//                    initialValue: "I am smart",
//                    onSaved: (String val) {
//                      setWith = val;
//                    },
                    controller: _withCtr,
                    decoration: InputDecoration(
                      hintText: record.memo
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
//                  Text(id),
//                  Text(record.memo),
                ],
              ),
            ),
          ),
        );

  }





}





/*import 'package:flutter/material.dart';

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
}*/
