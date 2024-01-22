import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomUI {
  static Widget customTextField(
      TextEditingController controller, String text, IconData iconData, bool toHide) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: TextField(
        controller: controller,
        obscureText: toHide,
        decoration: InputDecoration(
            hintText: text,
            suffixIcon: Icon(iconData),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
      ),
    );
  }

  static Widget customButton(VoidCallback voidCallback, String text, TextEditingController securityKeyController) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
        onPressed: voidCallback,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }

  static Widget pasteButton(TextEditingController securityKeyController) {
    return IconButton(
      icon: Icon(Icons.paste),
      onPressed: () async {
        String? clipboardText = await FlutterClipboard.paste();
        if (clipboardText != null) {
          securityKeyController.text = clipboardText;
        }
      },
    );
  }
}

