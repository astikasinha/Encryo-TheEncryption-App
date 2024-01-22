import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crypto/crypto.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(VideoEncrypt());
}

class VideoEncrypt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VideoPicker(),
    );
  }
}

class VideoPicker extends StatefulWidget {
  @override
  _VideoPickerState createState() => _VideoPickerState();
}

class _VideoPickerState extends State<VideoPicker> {
  File? _videoFile;
  TextEditingController _keyController = TextEditingController();
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
        _controller = VideoPlayerController.file(_videoFile!)
          ..initialize().then((_) {
            setState(() {});
          });
      });
    }
  }

  String _encodeVideoToBase64(File videoFile) {
    List<int> videoBytes = videoFile.readAsBytesSync();
    String base64String = base64Encode(videoBytes);
    return base64String;
  }

  String _encryptBase64String(String base64String, String key) {
    List<int> keyBytes = utf8.encode(key);
    List<int> base64Bytes = utf8.encode(base64String);

    for (int i = 0; i < base64Bytes.length; i++) {
      base64Bytes[i] ^= keyBytes[i % keyBytes.length];
    }

    String encryptedString = base64Encode(Uint8List.fromList(base64Bytes));
    return encryptedString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encrypt Video'),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.blue[50],
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Pick Video from Gallery',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontFamily: 'kalnia',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (_videoFile != null)
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                onPressed: _pickVideo,
                child: Text('Pick Video',style: TextStyle(color: Colors.black, fontSize: 21),),
              ),
              SizedBox(height: 20),
              if (_videoFile != null)
                Column(
                  children: [
                    SingleChildScrollView(
                      child: TextField(
                        controller: _keyController,
                        decoration: InputDecoration(
                          labelText: 'Enter Encryption Key',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                      onPressed: () {
                        String base64String = _encodeVideoToBase64(_videoFile!);
                        String key = _keyController.text;
                        String encryptedString =
                        _encryptBase64String(base64String, key);
                        _showEncryptedStringDialog(encryptedString);
                      },
                      child: Text('Encrypt and Display',style: TextStyle(color: Colors.black, fontSize: 21),),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEncryptedStringDialog(String encryptedString) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue[50],
          title: Text('Encrypted String',style: TextStyle(color: Colors.black, fontSize: 21),),
          content: Text(encryptedString,style: TextStyle(color: Colors.black, fontSize: 5),),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close',style: TextStyle(color: Colors.black, fontSize: 21),),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
