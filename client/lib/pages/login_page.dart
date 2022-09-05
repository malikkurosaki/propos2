import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
// import 'package:flutter_web_bluetooth/web/js/js_supported.dart';
import 'package:propos/components/input.dart';
import 'package:propos/components/save_button.dart';
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
    await 1.delay();
    if (Vl.userId.val.isNotEmpty) {
      Get.offAllNamed(Pages.homePage().route);
    }

    // final gt = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/albums/1"));
    // debugPrint(gt.body);
  }

  // 3484028339470336

  @override
  Widget build(BuildContext context) {
    _load();
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
                  child: _loginOwner(media),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _loginOwner(SizingInformation media) {
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
                            'Login As Owner',
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

                                  final login = await RouterAuth.login(body);
                                  if (login.statusCode == 200) {
                                    final data = jsonDecode(login.body);
                                    Vl.userId.val = data['userId'];

                                    // final getDefaultPref = await RouterApi.defaultPrefUserGet().getData();
                                    // if(getDefaultPref.statusCode == 200){
                                    //   final dataPref = jsonDecode(getDefaultPref.body);
                                    // }else{

                                    //   final bodyPref = {
                                    //     "userId": data['userId'],
                                    //     "companyId": data['companyId'],
                                    //     "outletId": data['outletId']
                                    //   };

                                    //   final setDefault = await RouterApi.defaultPrefUserPost().postData(bodyPref);
                                    //   debugPrint(setDefault.body);

                                    //   Vl.companyId.val = data['companyId'];
                                    //   Vl.outletId.val = data['outletId'];

                                    //   // Vl.defUser.val = data['user'];
                                    //   // Vl.defCompany.val = data['company'];
                                    //   // Vl.defOutlet.val = data['outlet'];
                                    //   Get.offAllNamed(Pages.homePage().route);

                                    // }

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
                //
                final body = {"deviceId": conDeviceId.text};
                final conPassword = TextEditingController();

                if (body.values.contains("")) {
                  Notif.error(message: "device id tidak boleh kosong");
                  return;
                }

                debugPrint("diangkat");
                final data = await RouterAuth.loginDevice(body);

                final dataBody = {}.obs;
                if (data.statusCode == 200) {
                  final dataDevice = jsonDecode(data.body);
                  final listEmployee = (jsonDecode(data.body)['Outlet']['Employee'] as List);
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
                              Ink(
                                color: Colors.grey.shade200,
                                child: Row(
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
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.home_work_rounded,
                                          color: Colors.cyan,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            dataDevice['Company']['name'].toString(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.store,
                                          color: Colors.cyan,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            dataDevice['Outlet']['name'].toString(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Flexible(
                                child: ListView(
                                  controller: ScrollController(),
                                  children: [
                                    Visibility(
                                      visible: listEmployee.isEmpty,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.warning,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Empty..!"),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ...listEmployee.map(
                                      (e) => ListTile(
                                        onTap: () {
                                          debugPrint(e.toString());
                                          dataBody.assignAll(e);
                                        },
                                        leading: Icon(
                                          Icons.account_box_rounded,
                                          color: Colors.cyan,
                                        ),
                                        title: Text(e['name'].toString()),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Obx(
                                () => Visibility(
                                  visible: dataBody.isNotEmpty,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8),
                                              child: Text("Password for ${dataBody['name'].toString()}"),
                                            ),
                                            TextField(
                                              controller: conPassword,
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.lock,
                                                    color: Colors.cyan,
                                                  ),
                                                  filled: true,
                                                  isDense: true,
                                                  label: Text("password"),
                                                  border: OutlineInputBorder(borderSide: BorderSide.none)),
                                            ),
                                            MaterialButton(
                                              color: Colors.cyan,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Center(
                                                    child: Text(
                                                  "Masuk",
                                                  style: TextStyle(color: Colors.white),
                                                )),
                                              ),
                                              onPressed: () async {
                                                if (conPassword.text.isEmpty) {
                                                  Notif.error(message: "password canot be empty");
                                                  return;
                                                }

                                                //  3484028339470336

                                                dataBody['password'] = conPassword.text;
                                                final dataLogin = await RouterAuth.loginCashier(dataBody);

                                                if (dataLogin.statusCode == 200) {
                                                  final dataUser = (jsonDecode(dataLogin.body) as Map);

                                                  debugPrint(dataUser.toString());

                                                  // debugPrint(dataUser.toString());
                                                  // Vl.userId.val = dataUser['userId'];
                                                  // Vl.companyId.val = dataUser['companyId'];
                                                  // Vl.outletId.val = dataUser['outletId'];
                                                  // Vl.employeeId.val = dataUser['id'];

                                                  // Get.offAllNamed(Pages.empHomePage().route);
                                                } else {
                                                  Notif.error(message: "wrong password");
                                                }
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
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
