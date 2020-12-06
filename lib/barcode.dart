import 'package:flutter/material.dart';
import 'dart:io';

class Barcode extends StatefulWidget {
  final File image;

  const Barcode({Key key, this.image}) : super(key: key);
  @override
  _BarcodeState createState() => _BarcodeState(image);
}

class _BarcodeState extends State<Barcode> {
  final File image;
  _BarcodeState(this.image);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
