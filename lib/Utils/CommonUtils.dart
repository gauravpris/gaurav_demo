import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonUtils {
  static CommonUtils? commonUtils;

  static CommonUtils getIntance() {
    commonUtils ??= CommonUtils();
    return commonUtils!;
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      timeInSecForIosWeb: 5,
    );
  }
}
