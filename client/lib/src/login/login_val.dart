import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginVal{
  static final listCompany = [].obs;
  static final listoutlet = [].obs;
  static final listDevice = [].obs;
  static final selectedCompany = {}.obs;
  static final selectedOutlet = {}.obs;
  static final selectedDevice = {}.obs;

  static final conEmail = TextEditingController(text: "wayan@gmail.com");
  static final conPassword = TextEditingController(text: "123456");
}