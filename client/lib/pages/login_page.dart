import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_web_bluetooth/web/js/js_supported.dart';
import 'package:propos/pages.dart';
import 'package:propos/utils/notif.dart';
import 'package:propos/utils/router_api.dart';
import 'package:propos/utils/router_auth.dart';
import 'package:propos/utils/img_def.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/val_def.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _bisaClick = true.obs;

  _load() async {
    final gt = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/albums/1"));
    debugPrint(gt.body);
  }

  // 3484028339470336

  @override
  Widget build(BuildContext context) {
    // _load();
    return ResponsiveBuilder(
      builder: (context, media) {
        return SafeArea(
          child: Material(
            child: Row(
              children: [
                Expanded(
                  child: Visibility(
                    visible: media.isDesktop,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: ImgDef.probusSystem(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 360,
                  height: Get.height,
                  child: _loginForm(media),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _loginForm(SizingInformation media) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Card(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: ScrollController(),
                  children: [
                    SizedBox(height: 200, child: ImgDef.login()),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Tooltip(
                          message: "silahkan isi semua dengan lengkap dari data yang anda dapatkan dari register",
                          child: Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _conEmail,
                        decoration: InputDecoration(
                          hintText: "Email",
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _conPassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                    ),
                    Obx(
                      () => !_bisaClick.value
                          ? MaterialButton(
                              onPressed: null,
                              child: Text("loading ..."),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  _bisaClick.value = false;
                                  final body = {
                                    "email": _conEmail.text,
                                    "password": _conPassword.text,
                                  };
        
                                  if (body.values.contains("")) {
                                    SmartDialog.showToast('Please fill all the fields');
                                    return;
                                  }
        
                                  debugPrint(body.toString());
        
                                  final login = await RouterAuth.login(body);
                                  if (login.statusCode == 200) {
                                    final data = jsonDecode(login.body);
                                    Vl.userId.val = data['userId'];
                                    Vl.companyId.val = data['companyId'];
                                    Vl.outletId.val = data['outletId'];
        
                                    Vl.defUser.val = data['user'];
                                    Vl.defCompany.val = data['company'];
                                    Vl.defOutlet.val = data['outlet'];
                                    Get.offAllNamed(Pages.homePage().route);
                                  } else {
                                    SmartDialog.showToast(login.body);
                                  }
        
                                  _bisaClick.value = true;
                                },
                              ),
                            ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(Pages.forgotPasswordPage().route);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_history,
                                  color: Colors.blue,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Forgot Password?"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(Pages.registerPage().route);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.new_releases_sharp,
                                  color: Colors.orange,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Register"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    _cashier(context)
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _cashier(BuildContext context) {
    final conDeviceId = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "I am a cashier",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Tooltip(
                message: "masukkan device id yang telah diberikan kepada anda",
                child: Icon(
                  Icons.info,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: conDeviceId,
              decoration: InputDecoration(
                hintText: "Device Id",
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.account_balance_wallet),
                suffixIcon: IconButton(
                  icon: Icon(Icons.qr_code_scanner_rounded),
                  onPressed: () {
                    Get.dialog(
                      SimpleDialog(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Qr Scanner",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    color: Colors.black12,
                                    child: Center(
                                      child: Text("Qr Scanner"),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Enter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              onPressed: () async {
                final body = {"deviceId": conDeviceId.text};

                if (body.values.contains("")) {
                  Notif.error(message: "device id tidak boleh kosong");
                  return;
                }

                debugPrint("diangkat");
                final data = await RouterAuth.loginDevice(body);

                debugPrint(data.body);

                if (data.statusCode == 200) {
                  
                  showBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (c) => SizedBox(
                      width: double.infinity,
                      height: Get.height * 0.9,
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Material(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: BackButton(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Select User"),
                                  )
                                ],
                              ),
                              Text("ini ada dimana")],
                          ),
                        ),
                      ),
                    ),
                  );
                  return;
                }

                Notif.error(message: "Email atau Password Salah");
              },
            ),
          )
        ],
      ),
    );
  }
}
