import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/Database/model.dart';
import 'package:todo/Database/service.dart';
import 'package:todo/edit_screen.dart';


// import 'package:todo/ToDo.dart';
// import 'package:todo/item.dart';

class menu extends StatefulWidget {
  const menu({super.key});

  @override
  State<menu> createState() => _menuState();
}
TextEditingController noteCon = TextEditingController();
class _menuState extends State<menu> {
  late List<Models> _userList = <Models>[];
  var _userServices = UserService();
  @override
  void initState() {
    super.initState();
    getdata();
  }


  getdata() async{
    var userdata= await _userServices.readData();
    _userList= <Models>[];

    userdata.forEach((rowdata){
      setState(() {
        var _models =Models();
        _models.id=rowdata['id'];
        _models.Note = rowdata['Note'];
        _userList.add(_models);
      });
    });


  }


  @override
  Widget build(BuildContext context) {
    // final todosList = ToDo.todolist();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.person),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            // SizedBox(width: 350,),
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/image/mehul.jpg'),
            )
          ],
        ),
      ),
      body: Stack(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              searchbox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'All ToDos',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
         Padding(
           padding: const EdgeInsets.only(top: 140,bottom: 80),
           child: ListView.builder(itemCount: _userList.length,itemBuilder: (context,index){
             return Padding(
               padding: const EdgeInsets.only(top: 10),
               child: Container(
                 // margin: EdgeInsets.only(bottom: 20),
                 child: ListTile(
                     tileColor: Colors.white,
                     onTap: () {
               
                       // ontodochange(todo);
               
                     },
                     contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                     shape:
                     RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                     // leading: IconButton(onPressed: (){},icon: Icon(Icons.add),),
                     leading: Text('${_userList[index].id}'),
               
                     title: Text(
                       '${_userList[index].Note}',
                       style: TextStyle(
                         fontSize: 16,
                         color: Colors.black,
                       ),
                     ),
                     // subtitle: Text('mehul'),
                     trailing: Wrap(
                       children:[
                         Container(
                           height: 35,
                           width: 35,
                           padding: EdgeInsets.all(0),
                           margin: EdgeInsets.symmetric(vertical: 4),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5), color: Colors.green),
               
                           child:  IconButton(onPressed: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>MyEdit(usermodels:_userList[index],mynote: _userList[index].Note!,)));
                         }, icon: Icon(Icons.edit)),),
               
                          SizedBox(width: 10,),
                         Container(
                           height: 35,
                           width: 35,
                           padding: EdgeInsets.all(0),
                           margin: EdgeInsets.symmetric(vertical: 4),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5), color: Colors.red),
                           child: IconButton(
                             onPressed: () {
                               setState(() {
                                 var _models=Models();
                                 var _service=UserService();
                                 setState(() {
                                   _models.id = _userList[index].id;
                                 });
                                 var result= _service.deleteData(_models);
                               });
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>menu()));
                             },
                             icon: Icon(
                               Icons.delete,
                               color: Colors.white,
                             ),
                             iconSize: 18,
                           )),]
                     )),
               ),
             );
           }
                   ),
         ),
        // ListView.builder(itemCount: _userList.length,itemBuilder: (context,index){
        //   return Container(
        //     // margin: EdgeInsets.only(bottom: 20),
        //     child: ListTile(
        //         tileColor: Colors.white,
        //         onTap: () {
        //
        //           // ontodochange(todo);
        //
        //         },
        //         contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        //         shape:
        //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //         // leading: IconButton(onPressed: (){},icon: Icon(Icons.add),),
        //         leading: Text('${_userList[index].id}'),
        //
        //         title: Text(
        //           '${_userList[index].Note}',
        //           style: TextStyle(
        //             fontSize: 16,
        //             color: Colors.black,
        //           ),
        //         ),
        //         subtitle: Text('mehul'),
        //         trailing: Container(
        //             height: 35,
        //             width: 35,
        //             padding: EdgeInsets.all(0),
        //             margin: EdgeInsets.symmetric(vertical: 4),
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(5), color: Colors.red),
        //             child: IconButton(
        //               onPressed: () {},
        //               icon: Icon(
        //                 Icons.delete,
        //                 color: Colors.white,
        //               ),
        //               iconSize: 18,
        //             ))),
        //   );
        // }),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                  child: Container(
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
                  controller: noteCon,
                    decoration: InputDecoration(
                        hintText: 'Add new todo item',
                        border: InputBorder.none)),
              )),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(60, 60), elevation: 10),
                    onPressed: () {

                      setState(() {
                        var _models = Models();
                        var _service = UserService();
                        _models.Note=noteCon.text;
                        var result = _service.savedata(_models);
                        print('succesfully sent');
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>menu()));
                    },
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    )),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 580),
          child: Lottie.network('https://lottie.host/b410efa5-f74d-4b6f-87d0-c3f02503f413/DpzbTpMA6k.json',height: 130,width: 60),
        ),
      ]),
    
     
    );
  }

  // void _handletodochange(ToDo toDo) {
  //   setState(() {
  //     toDo.isDone = !toDo.isDone;
  //   });
  // }

}

Widget searchbox() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          // width: 300,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 20,
                  ))),
        ),
      ],
    ),
  );
}
