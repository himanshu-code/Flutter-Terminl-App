import "package:flutter/material.dart";

class MyHome extends StatefulWidget{
@override
_MyHomeState createState()=> _MyHomeState();
}
class _MyHomeState extends State<MyHome>{
  @override
  Widget build(BuildContext context){
     var Homeicon=Icon(Icons.home,color: Colors.grey,);
  var HomeButton=IconButton(icon: Homeicon, onPressed: null);
  
  var logo=Image.network("https://firebasestorage.googleapis.com/v0/b/terminalapp-13f99.appspot.com/o/%E2%80%94Pngtree%E2%80%94vector%20programming%20icon_4102577.png?alt=media&token=c1bfd6bb-7501-4310-b544-69f7e75e259c");
  var loginButton=MaterialButton(onPressed:(){ Navigator.pushNamed(context, "login"); },minWidth: 150,color: Colors.black, textColor: Colors.white,padding: EdgeInsets.all(20),splashColor: Colors.red,child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 25),),);
  var registerButton=MaterialButton(onPressed:(){ Navigator.pushNamed(context, "reg"); },minWidth: 150,color: Colors.black, textColor: Colors.white,padding: EdgeInsets.all(20),splashColor: Colors.red,child: Text("Register",style: TextStyle(color: Colors.white,fontSize: 25),),);
  var container=Container(alignment: Alignment.bottomCenter,
                          //margin: EdgeInsets.all(10),
                          height: 320,
                          width: 320,
                          //padding: EdgeInsets.all(100),
                          decoration: BoxDecoration(color: Colors.red,borderRadius:BorderRadius.circular(150) ),
                          child: Column( mainAxisAlignment: MainAxisAlignment.center,

                                         children: <Widget>[Container(margin: EdgeInsets.all(10),child: loginButton),
                                         Container(margin: EdgeInsets.all(10),child: registerButton),
                                         ],

                          ),
                          );
  var appbar=AppBar(leading: logo, title: Text("TerminalApp"),actions: <Widget>[HomeButton],backgroundColor: Colors.purple);
  var myHome=Scaffold(appBar: appbar,body: Center(child: container), backgroundColor: Colors.black,);
  var design=MaterialApp(home:myHome,debugShowCheckedModeBanner: false,);
  return design;
  }

}