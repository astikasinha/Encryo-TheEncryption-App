import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import '../Text/decryption_text.dart';

/*class EnterSecurityKey extends StatefulWidget {
  const EnterSecurityKey({Key? key}) : super(key: key);

  @override
  _EnterSecurityKeyState createState() => _EnterSecurityKeyState();
}

class _EnterSecurityKeyState extends State<EnterSecurityKey> {
  final TextEditingController securityKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Security Key'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter the Security Key",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: securityKeyController,
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
                        securityKeyController.text = clipboardText;
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text("ENTER"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              onPressed: () {
                // Replace the code with your logic
                CollectionReference collRef = FirebaseFirestore.instance.collection('document');
                collRef.add({
                  'securityKey': securityKeyController.text,
                });

                // Replace with your navigation logic
                Navigator.push(context, MaterialPageRoute(builder: (context) => DecryptionText()));// Close current screen
              },
            ),
          ],
        ),
      ),
    );
  }
}*/

