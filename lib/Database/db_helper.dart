import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase
{
  Future<Database> setdata() async{
    var dir = await getApplicationDocumentsDirectory();
    var path = join(dir.path,'mydb');
    var database = openDatabase(path,version: 1,onCreate: Mytable);
    return database;
  }
  
  
  Future<void> Mytable(Database Notesdb,int version)async{
    String? sql='CREATE TABLE notes(id integer primary key autoincrement,Note text,Desc text)';
    return Notesdb.execute(sql);
  }
}