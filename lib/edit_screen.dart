import 'package:flutter/material.dart';
import 'package:todo/Database/model.dart';
import 'package:todo/Database/service.dart';
import 'package:todo/home.dart';

class MyEdit extends StatefulWidget {
  Models usermodels;
  String mynote;
   MyEdit({required this.usermodels,required this.mynote});

  @override
  State<MyEdit> createState() => _MyEditState();
}
TextEditingController NoteCon = TextEditingController();
class _MyEditState extends State<MyEdit> {
  void initState() {
    super.initState();
    setState(() {
      noteCon.text = widget.usermodels.Note!;

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data'),
      ),
      body: Card(

        elevation: 20,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Update Data',
            style:
            TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        Container(
          margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0)
              ],
              borderRadius: BorderRadius.circular(10)),
          child: TextField(
              controller: NoteCon,
              minLines: 10,
              maxLines: 25,
              decoration: InputDecoration(
                  label: Text(widget.mynote),
                  hintText: 'Add your updates',
                  border: InputBorder.none)),
        ),
        ElevatedButton(onPressed: (){

          setState(() {
            var _models=Models();
            var _service = UserService();
            // _models.id=
            _models.Note = NoteCon.text;
            _models.id = widget.usermodels.id;
            var result = _service.updateData(_models);
          });
          Navigator.push(context, MaterialPageRoute(builder: (context)=>menu()));
        }, child: Text('Update'))
      ],),),
    );
  }
}
