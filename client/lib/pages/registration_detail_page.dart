import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:propos/pages.dart';
import 'package:propos/utils/router_auth.dart';
import 'package:propos/utils/router_master.dart';
import 'package:propos/utils/img_def.dart';
import 'package:propos/utils/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegistrationDetailPage extends StatelessWidget {
  RegistrationDetailPage({Key? key}) : super(key: key);
  final _conJenisUsahaId = TextEditingController();
  final _conNamaUsaha = TextEditingController();
  final _conNamaPemilik = TextEditingController();
  final _conAlamat = TextEditingController();
  final _conNoTelp = TextEditingController();
  final _conOutlet = TextEditingController();
  final _conJumlahKaryawan = TextEditingController();

  final _listJenisUsaha = [].val('RegistrationDetailPage.listJenisUsaha').obs;

  // final _listJenisUsaha = [
  //   "warung",
  //   "restoran",
  //   "kafe",
  //   "barber shop",
  //   "beauty salon",
  //   "spa",
  //   "klinik",
  //   "laundry",
  //   "toko",
  //   "bengkel",
  //   "konter hp",
  //   "lainnya"
  // ];

  _onLoad() async {
    final jenisUsaha = await RouterMaster.jenisUsaha();
    if (jenisUsaha.statusCode == 200) {
      _listJenisUsaha.value.val.assignAll(jsonDecode(jenisUsaha.body));
      _listJenisUsaha.refresh();
    }

    // debugPrint(jenisUsaha.body);
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return ResponsiveBuilder(builder: (context, media) {
      return SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: Visibility(
                      visible: !media.isMobile,
                      child: Center(
                        child: ImgDef.probusSystem(),
                      ),
                    ),
                  ),
                  Drawer(
                    elevation: 0,
                    width: media.isMobile ? Get.width : 360,
                    child: ListView(
                      children: [
                        DrawerHeader(
                          child: ImgDef.registrationDetail(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(Val.userIdTmp.val),
                        ),
                        // dropdown jenis usaha
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField<Map>(
                              decoration: InputDecoration(
                                label: Text("Jenis Usaha"),
                                hintText: "Jenis Usaha",
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              items: [
                                for (var item in _listJenisUsaha.value.val)
                                  DropdownMenuItem(
                                    value: item,
                                    child: Text(item['name'].toString()),
                                  ),
                              ],
                              onChanged: (Map? value) {
                                _conJenisUsahaId.text = value!['id'].toString();
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _conNamaUsaha,
                            decoration: InputDecoration(
                              label: Text("Nama Usaha"),
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
                          child: TextFormField(
                            controller: _conOutlet,
                            decoration: InputDecoration(
                              label: Text("Outlet"),
                              hintText: "Nama Outlet",
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
                            controller: _conAlamat,
                            decoration: InputDecoration(
                              label: Text("Alamat"),
                              hintText: "Alamat",
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
                            controller: _conNoTelp,
                            decoration: InputDecoration(
                              label: Text("No Telp"),
                              hintText: "Nomer Telpon / Wa",
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
                            controller: _conJumlahKaryawan,
                            decoration: InputDecoration(
                              label: Text("Jumlah Karyawan"),
                              hintText: "Jumblah Karyawan",
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
                            controller: _conNamaPemilik,
                            decoration: InputDecoration(
                              label: Text("Nama Pemilik"),
                              hintText: "Nama Pemilik",
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
                            color: Colors.cyan,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Simpan",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              final body = {
                                "nameBusiness": _conNamaUsaha.text,
                                "nameOutlet": _conOutlet.text,
                                "nameOwner": _conNamaPemilik.text,
                                "address": _conAlamat.text,
                                "phone": _conNoTelp.text,
                                "numberEmployees": _conJumlahKaryawan.text,
                                "mJenisUsahaId": _conJenisUsahaId.text,
                                "userId": Val.userIdTmp.val,
                              };

                              // debugPrint(body.toString());

                              if (body.values.contains("")) {
                                SmartDialog.showToast("Lengkapi Data");
                                return;
                              }

                              if (int.tryParse(body['phone']!) == null) {
                                SmartDialog.showToast("Nomer Telpon / Wa Tidak Valid");
                                return;
                              }

                              if (int.tryParse(body['numberEmployees']!) == null) {
                                SmartDialog.showToast("Jumlah Karyawan Tidak Valid");
                                return;
                              }

                              final detail = await RouterAuth.registerDetail(body);

                              if (detail.statusCode == 201) {
                                await SmartDialog.showToast("Berhasil");
                                Get.offAllNamed(Pages.loginPage().route);
                              } else {
                                SmartDialog.showToast("Gagal");
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
