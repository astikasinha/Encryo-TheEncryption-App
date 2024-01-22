import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class sidebar extends StatefulWidget {
  const sidebar({super.key});

  @override
  State<sidebar> createState() => _sidebarState();
}

class _sidebarState extends State<sidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.blue[200],
      //width: double.infinity,
      height:200,
      padding: EdgeInsets.only(top:25),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Container(
            margin:EdgeInsets.only(bottom:10),
            height:70,
            decoration:BoxDecoration(
              shape:BoxShape.circle,
              image:DecorationImage(
                image:AssetImage('assets/images/sidebar encrypted.jpg'),

              )
            )
          ),
          Text("Encryo",style:TextStyle(color:Colors.black,fontSize:30),),
          Text("The Encryption App",style:TextStyle(color:Colors.black,fontSize:15),),


        ]
      )


    );
  }
}
