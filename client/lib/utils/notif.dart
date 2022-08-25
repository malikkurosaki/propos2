import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notif {
  static success({String message = "success"}) async {
    await 0.1.delay();
    Get.snackbar(
      "Success",
      message,
      backgroundColor: Colors.grey.shade800,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 4,
      borderWidth: 1,
      borderColor: Colors.grey[300],
      colorText: Colors.green,
      icon: Icon(
        Icons.check,
        color: Colors.green,
        size: 32,
      ),
    );
  }

  static error({String message = "error"}) async {
    await 0.1.delay();
    Get.snackbar(
      "ERROR",
      message,
      backgroundColor: Colors.grey.shade800,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 4,
      borderWidth: 1,
      borderColor: Colors.grey[300],
      colorText: Colors.grey,
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.error,
          color: Colors.pink,
          size: 36,
        ),
      ),
    );
  }
}
