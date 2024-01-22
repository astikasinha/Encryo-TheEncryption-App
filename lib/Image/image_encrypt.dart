import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageEncrypt extends StatefulWidget {
  ImageEncrypt({Key? key}) : super(key: key);

  @override
  State<ImageEncrypt> createState() => _ImageEncryptState();
}

class _ImageEncryptState extends State<ImageEncrypt> {
  Uint8List? _imageBytes;
  String? _imagePath;
  String? _encryptionKey;
  String? _encryptedString;
  final ImagePicker _picker = ImagePicker();
  bool loading = false;
  double progress = 0.0;
  final Dio dio = Dio();

  Future<bool> saveFile(String encryptedString, String fileName) async {
    Directory? directory;

    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          print(directory!.path);
          String newPath = "";
          List<String> folders = directory.path.split("/");
          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/" + folder + "/";
            } else {
              break;
            }
          }
          newPath = newPath + "EncryoApp";
          directory = Directory(newPath);
          print(directory!.path);
        } else {
          return false;
        }
      }
      if (!await directory!.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File saveFile = File(directory.path + "/$fileName");
        await dio.download(encryptedString, saveFile.path,
            onReceiveProgress: (downloaded, totalSize) {
              setState(() {
                progress = downloaded / totalSize;
              });
            });

        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  void pickImageBase64() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null || _encryptionKey == null) return;

    Uint8List imageBytes = await image.readAsBytes();
    String base64String = base64.encode(imageBytes);

    _encryptedString = encryptWithKey(base64String, _encryptionKey!);

    setState(() {
      _imageBytes = imageBytes;
      _imagePath = image.path;
    });
  }

  String encryptWithKey(String data, String key) {
    String encryptedData = sha256.convert(utf8.encode(data + key)).toString();
    return encryptedData;
  }

  void copyToClipboard() {
    if (_encryptedString != null) {
      Clipboard.setData(ClipboardData(text: _encryptedString!));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Encrypted String copied to clipboard'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encrypt Image'),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _imageBytes == null
                  ? Container()
                  : Image.memory(_imageBytes!, height: 250, width: 250),
              _imagePath != null
                  ? Text('Image Path: $_imagePath')
                  : Container(),
              _encryptedString != null
                  ? Column(
                children: [
                  Text('Encrypted String: $_encryptedString'),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                    onPressed: copyToClipboard,
                    child: Text('Copy Encrypted string',style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),),
                  ),
                ],
              )
                  : Container(),
              Container(
                color: Colors.blue[50],
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Pick Image from Gallery',
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
                onChanged: (value) {
                  setState(() {
                    _encryptionKey = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Enter Encryption Key',
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                onPressed: () {
                  pickImageBase64();
                },
                child: Text(
                  'Pick Image',
                  style: TextStyle(color: Colors.black, fontSize: 21),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
