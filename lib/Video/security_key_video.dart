
import 'dart:math';

import 'package:astikasencryptdecrypt/Text/encryption_text.dart';
import 'package:astikasencryptdecrypt/Video/video_encrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

import '../Image/image_encrypt.dart';

class SecurityKeyVideo extends StatefulWidget {
  SecurityKeyVideo({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final securityKeyController = TextEditingController();
  String value = '';

  @override
  _SecurityKeyState createState() => _SecurityKeyState();
}

class _SecurityKeyState extends State<SecurityKeyVideo> {
  String output = 'Your Security key';

  void copyToClipboard() {
    FlutterClipboard.copy(output);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Text copied to clipboard')),
    );
  }

  String generateSecurityKey(int length) {
    const charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return List.generate(length, (index) => charset[random.nextInt(charset.length)]).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[200],
        elevation: 0,
        title: const Text('Security Key'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Generate Security Key For Encryption",style: TextStyle(color: Colors.black,fontSize: 18),),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                onPressed: () {
                  setState(() {
                    output = generateSecurityKey(32);
                  });
                },
              ),
              SizedBox(height: 16),
              Text('$output'),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[50]),
                onPressed: () {
                  copyToClipboard();
                },
                child: Text('Copy to Clipboard',style: TextStyle(color: Colors.black,fontSize: 21),),
              ),
              SizedBox(height: 16),
              Text(
                "Enter Your Document Name",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: widget.nameController,
                decoration: InputDecoration(
                  hintText: "Document Name",
                  prefixIcon: Icon(Icons.drive_file_rename_outline, color: Colors.deepPurple),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Enter the Security Key",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: widget.securityKeyController,
                      decoration: InputDecoration(
                        hintText: "Security Key",
                        prefixIcon: Icon(Icons.security, color: Colors.deepPurple),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 1.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.paste),
                    onPressed: () async {
                      String? clipboardText = await FlutterClipboard.paste();
                      if (clipboardText != null) {
                        setState(() {
                          widget.securityKeyController.text = clipboardText;
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text("ENTER",style: TextStyle(color: Colors.black,fontSize: 21),),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                onPressed: () {
                  CollectionReference collRef = FirebaseFirestore.instance.collection('document');
                  collRef.add({
                    'name': widget.nameController.text,
                    'securityKey': widget.securityKeyController.text,
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoEncrypt(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

