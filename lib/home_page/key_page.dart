import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyPage extends StatefulWidget {
  const KeyPage({super.key});

  @override
  State<KeyPage> createState() => _KeyPageState();
}

class _KeyPageState extends State<KeyPage> {
  List searchResult=[];
  void searchFromFirebase(String query)async{
    final result=await FirebaseFirestore.instance.collection('document').where('name',
        isEqualTo: query).get();

    setState(() {
      searchResult=result.docs.map((e) => e.data()).toList();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Information Page"),
          centerTitle: true,
          backgroundColor: Colors.blue[200],
        ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15.0),
            color: Colors.blue[50],
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Search for the Documents for which you want to see the security key',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'kalnia',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),],),),
                SizedBox(height: 10), // Add some space between the text and the TextField
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Search Documents",
                      prefixIcon: Icon(Icons.search_outlined),
                    ),
                    onChanged: (query) {
                      searchFromFirebase(query);
                    },
                  ),
                ),



      Expanded(
                child:ListView.builder(
                    itemCount: searchResult.length,
                    itemBuilder:(context,index){
                      return ListTile(
                        title:Text(searchResult[index]['name']),
                        subtitle: Text(searchResult[index]['securityKey']),
                      );
                    })
            )
          ],
        )
    );
  }
}

