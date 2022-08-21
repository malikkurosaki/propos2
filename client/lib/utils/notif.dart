import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notif {
  static success({String message = "success"}) async {
    await 0.1.delay();
    Get.snackbar("Success", message,
        backgroundColor: Colors.grey[100], snackPosition: SnackPosition.BOTTOM, borderRadius: 4, borderWidth: 1, borderColor: Colors.grey[300], colorText: Colors.green, icon: Icon(Icons.check, color: Colors.green,
        
        ));
  }

  static error({String message = "error"}) async {
    await 0.1.delay();
    Get.snackbar("Error", message,
        backgroundColor: Colors.grey[100], snackPosition: SnackPosition.BOTTOM, borderRadius: 4, borderWidth: 1, borderColor: Colors.grey[300], colorText: Colors.red, icon: Icon(Icons.error, color: Colors.red,
        
        ));
  }
}
