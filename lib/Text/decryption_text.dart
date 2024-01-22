import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:clipboard/clipboard.dart';

void main() {
  runApp(DecryptText());
}

class DecryptText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DecryptionText(),
    );
  }
}

class DecryptionText extends StatefulWidget {
  @override
  _DecryptionTextState createState() => _DecryptionTextState();
}

class _DecryptionTextState extends State<DecryptionText> {
  final TextEditingController encryptedTextController = TextEditingController();
  final TextEditingController keyController = TextEditingController();

  String decryptedText = '';
  bool isDecrypting = false;

  @override
  void dispose() {
    encryptedTextController.dispose();
    keyController.dispose();
    super.dispose();
  }

  void copyToClipboard() {
    FlutterClipboard.copy(decryptedText);
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
        title: Text('Decrypt Text'),
      ),
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
                    'Enter the encrypted text',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'kalnia',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: encryptedTextController,
                decoration: InputDecoration(labelText: 'Encrypted Text'),
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
                decoration: InputDecoration(labelText: 'Decryption Key'),
                obscureText: true,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                onPressed: isDecrypting ? null : () => decryptText(context),
                child: isDecrypting
                    ? CircularProgressIndicator()
                    : Text('Decrypt',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              ),
              SizedBox(height: 20),
              Text(
                'Decrypted Text:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text('$decryptedText'),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                onPressed: () {
                  copyToClipboard();
                },
                child: Text('Copy to Clipboard',
                    style: TextStyle(color: Colors.black, fontSize: 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> decryptText(BuildContext context) async {
    try {
      setState(() {
        isDecrypting = true;
      });

      final key = encrypt.Key.fromUtf8(keyController.text.padRight(32));
      final iv = encrypt.IV.fromLength(16);

      final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: null),
      );

      final encrypted = encrypt.Encrypted.fromBase64(
          encryptedTextController.text);

      decryptedText = encrypter.decrypt(encrypted, iv: iv);

      setState(() {
        isDecrypting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Text decrypted successfully.'),
        ),
      );
    } catch (e) {
      print('Decryption error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Decryption error: $e'),
        ),
      );
      setState(() {
        isDecrypting = false;
      });
    }
  }
}

