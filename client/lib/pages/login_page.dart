import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:propos/pages.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/login/login_dialog_select.dart';
import 'package:propos/src/login/login_select_company.dart';
import 'package:propos/src/login/login_val.dart';
import 'package:propos/utils/img_def.dart';
import 'package:propos/utils/notif.dart';
import 'package:propos/utils/router_auth.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Visibility(
                    visible: media.isDesktop,
                    child: Stack(
                      children: [
                        ImgDef.bgLogin(height: Get.height, fit: BoxFit.cover),
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            height: 70,
                            width: 150,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ImgDef.probusSystem(fit: BoxFit.contain),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 430,
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
                        controller: LoginVal.conEmail,
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
                        controller: LoginVal.conPassword,
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
                      () => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: !_bisaClick.value
                            ? Center(
                                child: LinearProgressIndicator(),
                              )
                            : MaterialButton(
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
                                  Future.delayed(Duration(seconds: 3), () {
                                    _bisaClick.value = true;
                                  });

                                  Future.delayed(Duration(seconds: 3), () => _bisaClick.value = true);
                                  final body = {
                                    "email": LoginVal.conEmail.text,
                                    "password": LoginVal.conPassword.text,
                                  };

                                  if (body.values.contains("")) {
                                    SmartDialog.showToast('Please fill all the fields');
                                    return;
                                  }

                                  final res = await Rot.loginPost(body: {"data": jsonEncode(body)});
                                  if (res.statusCode == 201) {
                                    Vl.token.val = res.body;
                                    // LoginVal.listCompany.assignAll(jsonDecode(res.body));

                                    Rot.lgnListCompanyByUserIdGet().then(
                                      (res) {
                                        if (res.statusCode == 200) {
                                          LoginVal.listCompany.assignAll(jsonDecode(res.body));

                                          showBottomSheet(
                                            context: context,
                                            builder: (context) => Material(
                                              color: Colors.grey.shade100,
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                      "Please Completer This Action First",
                                                      style: TextStyle(fontSize: 24),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    title: DropdownSearch<Map>(
                                                      dropdownDecoratorProps: DropDownDecoratorProps(
                                                        dropdownSearchDecoration: InputDecoration(
                                                            filled: true,
                                                            border: InputBorder.none,
                                                            hintText: "Select Company"),
                                                      ),
                                                      items: [...LoginVal.listCompany],
                                                      itemAsString: (value) => value['name'].toString(),
                                                      onChanged: (value) async {
                                                        LoginVal.selectedCompany.assignAll(value!);

                                                        final listOutlet = await Rot.lgnListOutletByCompanyGet(
                                                          query: "companyId=${value['id']}",
                                                        );

                                                        if (listOutlet.statusCode == 200) {
                                                          LoginVal.listoutlet.assignAll(jsonDecode(listOutlet.body));
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  Obx(
                                                    () => ListTile(
                                                      title: LoginVal.listoutlet.isEmpty
                                                          ? Text("Select Outlet")
                                                          : DropdownSearch<Map>(
                                                              dropdownDecoratorProps: DropDownDecoratorProps(
                                                                dropdownSearchDecoration: InputDecoration(
                                                                    filled: true,
                                                                    border: InputBorder.none,
                                                                    hintText: "Select outlet"),
                                                              ),
                                                              items: [...LoginVal.listoutlet],
                                                              itemAsString: (value) => value['name'].toString(),
                                                              onChanged: (value) {
                                                                LoginVal.selectedOutlet.assignAll(value!);
                                                                Rot.lgnListDeviceByOutletGet(
                                                                        query: "outletId=${value['id']}")
                                                                    .then(
                                                                  (value) {
                                                                    // debugPrint(value.body.toString());
                                                                    if (value.statusCode == 200) {
                                                                      LoginVal.listDevice
                                                                          .assignAll(jsonDecode(value.body));
                                                                    }
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                    ),
                                                  ),
                                                  Obx(
                                                    () => ListTile(
                                                      title: LoginVal.listDevice.isEmpty
                                                          ? Text("Select Device")
                                                          : DropdownSearch<Map>(
                                                              dropdownDecoratorProps: DropDownDecoratorProps(
                                                                dropdownSearchDecoration: InputDecoration(
                                                                    filled: true,
                                                                    border: InputBorder.none,
                                                                    hintText: "Select outlet"),
                                                              ),
                                                              items: [...LoginVal.listDevice],
                                                              itemAsString: (value) => value['name'].toString(),
                                                              onChanged: (value) {
                                                                LoginVal.selectedDevice.assignAll(value!);
                                                              },
                                                            ),
                                                    ),
                                                  ),
                                                  Obx(
                                                    () => LoginVal.selectedCompany.isEmpty ||
                                                            LoginVal.selectedOutlet.isEmpty ||
                                                            LoginVal.selectedDevice.isEmpty
                                                        ? SizedBox.shrink()
                                                        : ListTile(
                                                            title: MaterialButton(
                                                              color: Colors.blue,
                                                              onPressed: () async {
                                                                final modelData = {
                                                                  "token": Vl.token.val,
                                                                  "deviceId": LoginVal.selectedDevice['id'],
                                                                  "userId": null,
                                                                  "companyId": LoginVal.selectedCompany['id'],
                                                                  "outletId": LoginVal.selectedOutlet['id']
                                                                };

                                                                final data = await Rot.lgnSetDefaultPost(
                                                                  body: {"data": jsonEncode(modelData)},
                                                                );

                                                                if (data.statusCode == 200) {
                                                                  Get.offNamed(Pages.homePage().route);
                                                                } else {
                                                                  SmartDialog.showToast(data.body.toString());
                                                                }
                                                              },
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: Text(
                                                                  "Simpan",
                                                                  style: TextStyle(color: Colors.white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  } else {
                                    SmartDialog.showToast(res.body);
                                  }

                                  // final login = await RouterAuth.login(body);
                                  // if (login.statusCode == 200) {
                                  //   final dataLogin = jsonDecode(login.body);
                                  //   final userId = dataLogin['id'];
                                  //   final userName = dataLogin['name'];
                                  //   final listCompany = List<Map>.from(dataLogin['Company']);
                                  //   LoginVal.selectedCompany
                                  //       .assignAll(listCompany.where((element) => element['idx'] == 1).toList().first);

                                  //   // disini
                                  //   showBottomSheet(
                                  //       context: context,
                                  //       builder: (context) => _popupSelect(listCompany, userId, userName));

                                  //   // Vl.userId.val = data['userId'];

                                  //   // debugPrint(Vl.deviceId.val.toString());

                                  //   // Vl.companyId.val = data['companyId'];
                                  //   // Vl.outletId.val = data['outletId'];

                                  //   // Vl.defUser.val = data['user'];
                                  //   // Vl.defCompany.val = data['company'];
                                  //   // Vl.defOutlet.val = data['outlet'];
                                  //   // Get.offAllNamed(Pages.homePage().route);
                                  // } else {
                                  //   SmartDialog.showToast(login.body);
                                  // }
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

  Widget _popupSelect(List<Map> listCompany, String userId, String userName) {
    return Column(
      children: [
        Flexible(
          child: ListView(
            children: [
              Row(
                children: [BackButton()],
              ),
              ImgDef.wellcome(),
              Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.business),
                    subtitle: Text("company"),
                    title: DropdownSearch<Map>(
                      onChanged: (value) async {
                        LoginVal.selectedCompany.assignAll(value!);
                        final res = await Rot.lgnListOutletByCompanyGet(query: "companyId=${value['id']}");
                        debugPrint(res.body);

                        if (res.statusCode == 200) {
                          LoginVal.listoutlet.assignAll(jsonDecode(res.body));
                        }
                      },
                      items: listCompany,
                      itemAsString: (value) => value['name'],
                      dropdownBuilder: (context, value) => Text(value!['name'].toString()),
                      selectedItem: LoginVal.selectedCompany,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => ListTile(
                      leading: Icon(Icons.store),
                      subtitle: Text("outlet"),
                      title: LoginVal.listoutlet.isEmpty
                          ? Text(
                              "Select Outlet",
                              style: TextStyle(color: Colors.grey),
                            )
                          : DropdownSearch<Map>(
                              items: [...LoginVal.listoutlet],
                              onChanged: (value) async {
                                LoginVal.selectedOutlet.assignAll(value!);
                                final res = await Rot.lgnListDeviceByOutletGet(query: "outletId=${value['id']}");
                                if (res.statusCode == 200) {
                                  LoginVal.listDevice.assignAll(jsonDecode(res.body));
                                }
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  filled: true,
                                  isDense: true,
                                  hintText: "Select Outlet",
                                  border: InputBorder.none,
                                ),
                              ),
                              itemAsString: (value) => value['name'],
                            ),
                    ),
                  ),
                  Obx(
                    () => ListTile(
                      leading: Icon(Icons.tablet),
                      subtitle: Text("device"),
                      title: LoginVal.listDevice.isEmpty
                          ? Text(
                              "Select Device",
                              style: TextStyle(color: Colors.grey),
                            )
                          : DropdownSearch<Map>(
                              items: [...LoginVal.listDevice],
                              onChanged: (value) {
                                LoginVal.selectedDevice.assignAll(value!);
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  filled: true,
                                  isDense: true,
                                  hintText: "Select Outlet",
                                  border: InputBorder.none,
                                ),
                              ),
                              itemAsString: (value) => value['name'],
                            ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Obx(
          () => !(() {
            final com = LoginVal.selectedCompany.isNotEmpty;
            final out = LoginVal.selectedOutlet.isNotEmpty;
            final dev = LoginVal.selectedDevice.isNotEmpty;

            return com && out && dev;
          })()
              ? Text("...")
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Center(
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Vl.userId.val = userId;
                      Vl.companyId.val = LoginVal.selectedCompany['id'];
                      Vl.outletId.val = LoginVal.selectedOutlet['id'];
                      Vl.deviceId.val = LoginVal.selectedDevice['id'];

                      Vl.defUser.val = {"id": userId, "name": userName};

                      Vl.defCompany.val = LoginVal.selectedCompany;
                      Vl.defOutlet.val = LoginVal.selectedOutlet;
                      Vl.defDevice.val = LoginVal.selectedDevice;

                      Get.toNamed(Pages.rootPage().route);
                    },
                  ),
                ),
        )
      ],
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
