import 'package:astikasencryptdecrypt/Text/decryption_text.dart';
import 'package:astikasencryptdecrypt/others/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*class Enter2 extends StatefulWidget {
  const Enter2({Key? key}) : super(key: key);

  @override
  State<Enter2> createState() => _Enter2State();
}

class _Enter2State extends State<Enter2> {
  TextEditingController documentNameController = TextEditingController();
  TextEditingController securityKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text("Enter Security key"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.blue[50],
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Enter Document Name and Security key!!",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'kalnia'),
              ),
            ),
          ),
          CustomUI.customTextField(
              documentNameController, "Document Name", Icons.onetwothree_sharp, false),
          CustomUI.customTextField(
              securityKeyController, "Security Key", Icons.security_sharp, true),
          SizedBox(height: 30),
          CustomUI.customButton(() {
            // You can perform actions when the button is pressed
            navigateToDecryptionScreen();
          }, "ENTER", securityKeyController),
        ],
      ),
    );
  }

  void navigateToDecryptionScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DecryptionText(
          encryptionKey: securityKeyController.text, // Use securityKeyController.text instead of keyEditingController.text
        ),
      ),
    );
  }
}*/
