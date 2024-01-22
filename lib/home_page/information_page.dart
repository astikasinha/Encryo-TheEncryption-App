import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        title: Text("Information Page"),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.blue[50],
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Encryo: The Encryption App',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'kalnia',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Text(
              '''This App only focuses on encryption of text, images, videos, and files. 
Images option converts the image into base64 string and using a security key performs encryption of the base64 string using AES.
Then write the encrypted string into a file.
The same goes for Video and File Options''',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

