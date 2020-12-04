import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';



class MyTerminalApp extends StatefulWidget{
  @override
  
  _MyTerminalAppState createState() => _MyTerminalAppState();
  
}

class _MyTerminalAppState extends State<MyTerminalApp> {
  // This widget is the root of your application.
  var fsconnect = FirebaseFirestore.instance;

  myget() async {
    var d = await fsconnect.collection("commands").get();
    // print(d.docs[0].data());

    for (var i in d.docs) {
      print(i.data());
    }
  }
  var webData;
  web(cmd,image_name) async{
  
  var url="http://192.168.43.142/cgi-bin/web.py?x=${cmd}&y=${image_name}";
  var response= await http.get(url);
  print(response.body);
  setState(() {
   webData=response.body;
  });
  fsconnect.collection("commands").add({
                                        'command': cmd,
                                        'image name': image_name,
                                        'output': webData,
                                        'time':DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now()),
                                          });
   
} 



  @override
  Widget build(BuildContext context) {
    
 String cmd;
  String image_name;
  var User_icon=Icon(Icons.person,color: Colors.blue,);
  var Home_icon=Icon(Icons.home, color:Colors.blue);

  var User_button=IconButton(icon: User_icon, onPressed: null);
  var Home_button=IconButton(icon: Home_icon, onPressed:(){Navigator.popAndPushNamed(context, "home");} );
   var url="https://cdn.pixabay.com/photo/2012/04/26/19/47/penguin-42936_960_720.png";
   var linux_image=NetworkImage(url);
   var url2="https://firebasestorage.googleapis.com/v0/b/terminalapp-13f99.appspot.com/o/%E2%80%94Pngtree%E2%80%94vector%20programming%20icon_4102577.png?alt=media&token=c1bfd6bb-7501-4310-b544-69f7e75e259c";
   var logo=Image.network(url2);
   var box=Container(height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.red,image: DecorationImage(image: linux_image,fit: BoxFit.fitWidth),),
                    child: Column(
                     children: <Widget>[
                       Expanded(
                         child: ListView(
                           children:<Widget>[
                              Container(width:300,
                                                 alignment: Alignment.topCenter,
                                                 //height: double.infinity,
                                                 margin: EdgeInsets.all(20),
                                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.black),                                                
                                                 child:StreamBuilder<QuerySnapshot>(
                                                           stream: fsconnect.collection("commands").orderBy('time').snapshots(),
                                                           builder: (context, snapshot){
                                                             var msg=(snapshot.data.docs==null)?null:snapshot.data.docs;
                                                             List<Widget> y=[];
                                                             for(var d in msg){
                                                               var output=(d.data==null)?null:d.data()['output'];
                                                               var outputwidget=Padding(padding: EdgeInsets.all(5) ,child:Column( crossAxisAlignment:CrossAxisAlignment.start ,children: <Widget>[
                                                                                MaterialButton( elevation: 30,color:Colors.grey ,padding: EdgeInsets.all(15), child: Text("$output  ",style: TextStyle(color: Colors.red ,fontWeight: FontWeight.w700),), onPressed: null,),
                                                               ],
                                                               )); 
                                                               y.add(outputwidget);          
                                                             }
                                                             print(y);
                                                             return Container( margin: EdgeInsets.only(top:20),
                                                             child: Column(
                                                               crossAxisAlignment: CrossAxisAlignment.stretch,
                                                               children: y,
                                                             ),
                                                             );
                                                           } ,
                                                         ) ,
                                                 ),
                           ],
                         ),
                       ),
                       Container(alignment: Alignment.center,
                                                  margin: EdgeInsets.all(10), 
                                                  width: 350,
                                                  
                                                  color:Colors.transparent,
                                                  child: TextField(onChanged: (value) { cmd=value;
                                                  
                                                  },
                                                    autocorrect: false,
                                                  textAlign: TextAlign.left,
                                                  cursorColor: Colors.purple,
                                                  decoration: InputDecoration(
                                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),),
                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    border: OutlineInputBorder(),
                                                    hintText: "Enter Command",
                                                    prefixIcon: Icon(Icons.send,color: Colors.red,),
                                                  ),
                                                  ),
                                                ),
                                      Container(alignment: Alignment.center,
                                                  margin: EdgeInsets.all(10),
                                                  width: 350,
                                                  color:Colors.transparent,
                                                  child: TextField( onChanged: (value) { image_name=value;},
                                                    autocorrect: false,
                                                  textAlign: TextAlign.left,
                                                  cursorColor: Colors.purple,
                                                  decoration: InputDecoration(
                                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),),
                                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    border: OutlineInputBorder(),
                                                    hintText: "Enter Image Name",
                                                    prefixIcon: Icon(Icons.send,color: Colors.red,),
                                                  ),
                                                  ),
                                                ),
                                                RaisedButton(
                                                  color: Colors.black,
                                                textColor: Colors.teal,
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.black,
                                                padding: EdgeInsets.all(10),
                                                
                                                splashColor: Colors.redAccent,
                                                  onPressed: () { 
                                                   web(cmd,image_name);
                                                  
                                                    },
                                                 child: Text("Run commands and add to Firebase")),
                     ],
                    ),
                    
                    );

  var appbar=AppBar(leading: logo,title: Text('TerminalApp',style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.normal,color: Colors.white),),
  actions: <Widget>[User_button,Home_button],
  backgroundColor: Colors.purple,
  );
  var myhome=Scaffold(appBar: appbar,
    body: box,
  );
    return myhome;
  }
}

