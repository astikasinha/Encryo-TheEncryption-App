import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'function.dart';

class G extends StatefulWidget {
  const G({super.key});

  @override
  State<G> createState() => _GState();
}

class _GState extends State<G> {
  String url='';
  var data;
  String output='initial output';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text('simple')),
      body:Center(
        child:Column(children:[
          TextField(
            onChanged:(value){
              url='http://10.0.0.2:5000/m?query='+value.toString();
            }
          ),
          TextButton(onPressed: ()async{
            data=await fetchdata(url);
            var decoded=jsonDecode(data);
            setState((){
              output=decoded['output'];

            });
          },child:Text('fetch ascii value')),
          Text(output)
        ]),
      ),

    );
    return const Placeholder();
  }
}
