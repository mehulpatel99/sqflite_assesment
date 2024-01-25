import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/Database/db_helper.dart';
class repo
{
  MyDatabase? _database;
  Database? _Mydatabase;

  repo(){
    _database=MyDatabase();
  }

  Future<Database?> get Notesdb async{
    if(_Mydatabase != null){
      return  _Mydatabase;
    }else{
      _Mydatabase= await _database?.setdata();
      return _Mydatabase;
    }
  }

  inser(table,data)async{
    var con = await Notesdb;
    return await con!.insert(table,data);
  }
  getData(table)async{
    var con = await Notesdb;
    return await con!.query(table);
  }
  update(table,data)async{
    var con=await Notesdb;
    return await con!.update(table, data,where: 'id=?',whereArgs: [data['id']]);
  }
  delete(table,data)async{
    var con=await Notesdb;
    return await con!.delete(table,where: 'id=?',whereArgs: [data['id']]);
  }
}