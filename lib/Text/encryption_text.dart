import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EncryptionText(),
    );
  }
}

class EncryptionText extends StatefulWidget {
  @override
  _EncryptionTextState createState() => _EncryptionTextState();
}

class _EncryptionTextState extends State<EncryptionText> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController keyController = TextEditingController();

  String encryptedText = '';
  bool isEncrypting = false;

  @override
  void dispose() {
    textController.dispose();
    keyController.dispose();
    super.dispose();
  }

  void copyToClipboard() {
    FlutterClipboard.copy(encryptedText);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Text copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[30],
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[200],
          title: Text('Encrypt Text')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.blue[50],
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Write the text you want to encrypt',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'kalnia',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: textController,
                decoration: InputDecoration(labelText: 'Input Text'),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.blue[50],
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Enter Security Key',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'kalnia',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: keyController,
                decoration: InputDecoration(labelText: 'Encryption Key'),
                obscureText: true,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                onPressed: isEncrypting ? null : () => encryptText(context),
                child: isEncrypting
                    ? CircularProgressIndicator()
                    : Text('Encrypt', style: TextStyle(color: Colors.black, fontSize: 20)),
              ),
              SizedBox(height: 20),
              Text(
                'Encrypted Text:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text('$encryptedText'),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                onPressed: () {
                  copyToClipboard();
                },
                child: Text('Copy to Clipboard',style: TextStyle(color: Colors.black, fontSize: 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> encryptText(BuildContext context) async {
    try {
      setState(() {
        isEncrypting = true;
      });


      final key = encrypt.Key.fromUtf8(keyController.text.padRight(32));
      final iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
      final encrypted = encrypter.encrypt(textController.text, iv: iv);

      setState(() {
        encryptedText = encrypted.base64;
        isEncrypting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Text encrypted successfully.'),
        ),
      );
    } catch (e) {
      print('Encryption error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Encryption error: $e'),
        ),
      );
      setState(() {
        isEncrypting = false;
      });
    }
  }
}



