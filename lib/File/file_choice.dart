import 'package:flutter/material.dart';

import 'file_security_key.dart';

class FileChoice extends StatelessWidget {
  const FileChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        elevation: 0,
        centerTitle: true,
        title: const Text('CHOICE SECTION!!'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/encryptionlock.jpg',height:200),
            Container(
              color:Colors.blue[50],
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Choose what you want to do?',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'kalnia',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: const Text("Generate Security Key For Encryption",
                style: TextStyle(color: Colors.black,fontSize: 20),),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FileSecurityKey()),
                );
              },
            ),
            SizedBox(height: 20,),
            /*ElevatedButton(
              child: Text("Enter Security Key for Decryption",
                style: TextStyle(color: Colors.black,fontSize: 21),),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DecryptionApp()),
                );
              },
            ),*/
          ],
        ),
      ),
    );
  }
}
