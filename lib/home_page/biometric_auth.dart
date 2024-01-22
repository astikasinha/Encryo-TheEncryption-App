import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'key_page.dart';

class BiometricAuth extends StatefulWidget {
  const BiometricAuth({Key? key}) : super(key: key);

  @override
  State<BiometricAuth> createState() => _BiometricAuthState();
}

class _BiometricAuthState extends State<BiometricAuth> {
  bool? _hasBioSensor;
  LocalAuthentication authentication = LocalAuthentication();

  Future<void> _getAuth(BuildContext context) async {
    bool isAuth = false;
    try {
      isAuth = await authentication.authenticate(
        localizedReason:
        'Scan your fingerprint to access the security keys and document name',
      );

      if (isAuth) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (builder) => KeyPage()),
        );
      }

      print(isAuth);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _checkBio() async {
    try {
      _hasBioSensor = await authentication.canCheckBiometrics;
      print(_hasBioSensor);
      if (_hasBioSensor!) {
        _getAuth(context);
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        title: Text('Biometric Authentication'),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.blue[50],
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Scan Your Finger/Face',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'kalnia',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              child: const Text(
                "SCAN",
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              onPressed: () {
                _checkBio();
              },
            ),
          ],
        ),
      ),
    );
  }
}
