import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

void main() {
  runApp(FileEncrypt());
}

class FileEncrypt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String encryptedBase64 = '';
  TextEditingController keyController = TextEditingController();

  Future<void> pickAndEncryptFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      Uint8List fileBytes = file.bytes!;
      String base64String = base64Encode(fileBytes);


      String encryptionKey = keyController.text;

      if (encryptionKey.isNotEmpty) {
        final encryptedBase64String = encryptString(base64String, encryptionKey);

        setState(() {
          encryptedBase64 = encryptedBase64String;
        });
      }
    }
  }

  String encryptWithKey(String data, String key) {
    String encryptedData = sha256.convert(utf8.encode(data + key)).toString();
    return encryptedData;
  }

  String encryptString(String input, String key) {
    final encrypt.Key encryptionKey = encrypt.Key.fromUtf8(key);
    final encrypt.IV iv = encrypt.IV.fromLength(16);
    final encrypt.Encrypter encrypter = encrypt.Encrypter(encrypt.AES(encryptionKey));

    final encrypted = encrypter.encrypt(input, iv: iv);
    return encrypted.base64;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encrypt Pdf File'),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.blue[50],
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Pick Pdf File from storage',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontFamily: 'kalnia',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TextField(
              controller: keyController,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Enter Encryption Key',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              onPressed: pickAndEncryptFile,
              child: Text('Pick File', style: TextStyle(color: Colors.black, fontSize: 21)),
            ),
            SizedBox(height: 20),
            Text(
              'Encrypted Base64 String:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            if (encryptedBase64.isNotEmpty)
              Text(
                encryptedBase64,
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
