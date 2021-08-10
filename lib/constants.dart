import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


const textfieldDecoration = InputDecoration(
   hintText: 'Enter value',
  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 90.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue,width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue,width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
);

const textfielddecoration2 = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  hintText: 'Text Message here',
    border: InputBorder.none

);

const conteinerdecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.blue,width: 2.0),

  )
);

const sendTextstyle = TextStyle(
  color: Colors.indigo,
  fontWeight: FontWeight.bold,
  fontSize: 11.0
);