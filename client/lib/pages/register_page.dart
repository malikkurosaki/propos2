import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/pages.dart';
import 'package:propos/utils/router_auth.dart';
import 'package:propos/utils/img_def.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conNamaUsaha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, media) {
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
                    Center(child: ImgDef.probusSystem()),
                  ],
                ),
              )),
              Container(
                color: Colors.white,
                width: media.isMobile ? Get.width : 360,
                child: Column(
                  children: [
                    Expanded(
                        child: ListView(
                      children: [
                        SizedBox(height: 200, child: ImgDef.register()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _conUserName,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: "User Name",
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _conEmail,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: "Email",
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _conPassword,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Password",
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _conNamaUsaha,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.home_work_rounded),
                              hintText: "Nama Usaha",
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
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
                                    "Register",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                final body = <String, String>{
                                  "name": _conUserName.text,
                                  "email": _conEmail.text,
                                  "password": _conPassword.text,
                                  "namaUsaha": _conNamaUsaha.text,
                                };

                                if (body.values.contains("")) {
                                  SmartDialog.show(
                                    builder: (context) => Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Please fill all the fields",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );

                                  return;
                                }

                                final reg = await RouterAuth.register(body);
                                if (reg.statusCode == 201) {
                                  final data = jsonDecode(reg.body);
                                  // Val.userIdTmp.val = data['id'];
                                  Vl.deviceId.val = data['deviceId'];

                                  await SmartDialog.showToast("Registered Successfully");
                                  Get.offAllNamed(Pages.loginPage().route);
                                } else {
                                  SmartDialog.showToast(reg.body);
                                }
                              }),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  Get.toNamed(Pages.loginPage().route);
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.login),
                                    ),
                                    Text("Login"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
