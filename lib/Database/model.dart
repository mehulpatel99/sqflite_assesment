import 'package:flutter/material.dart';

class Models{
  int? id;
  String? Note;
  String? Desc;

  Usermap(){
    var mapping = Map<String,dynamic>();
    mapping['id']=id;
    mapping['Note']=Note;
    mapping['Desc']= Desc;

    return mapping;
  }
}