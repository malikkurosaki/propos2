import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/product/product_val.dart';

class ProductEditOutlet extends StatelessWidget {
  ProductEditOutlet({Key? key}) : super(key: key);
  final listAvailable = [].obs;
  final listOutlet = [].obs;
  final reloadListAvailable = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "Outlet",
            style: TextStyle(fontSize: 24),
          ),
        ),
        Obx(
          () {
            reloadListAvailable.value;
            return SizedBox(
              height: 4,
              child: FutureBuilder<http.Response>(
                future: Rot.globalListOutletByProductIdGet(query: "id=${ProductVal.mapData.value.val['id']}"),
                builder: (con, snap) {
                  if (!snap.hasData) return LinearProgressIndicator();
                  () async {
                    if (snap.data!.statusCode == 200) {
                      await 0.1.delay();
                      listAvailable.assignAll(jsonDecode(snap.data!.body));
                    }
                  }();
                  return Container();
                },
              ),
            );
          },
        ),
        SizedBox(
          height: 4,
          child: FutureBuilder<http.Response>(
            future: Rot.globalOutletListByCompanyIdGet(query: "companyId=${ProductVal.mapData.value.val['companyId']}"),
            builder: (con, snap) {
              if (!snap.hasData) return LinearProgressIndicator();
              if (snap.data!.statusCode == 200) {
                () async {
                  await 0.1.delay();
                  listOutlet.assignAll(jsonDecode(snap.data!.body));
                }();
              }
              return Container();
            },
          ),
        ),
        Obx(
          () => Column(
            children: [
              ...listOutlet.map(
                (e) => ListTile(
                  title: CheckboxListTile(
                    title: Text(e['name'].toString()),
                    value: listAvailable.map((ee) => ee['outletId']).contains(e['id'] ),
                    onChanged: (val) async {
                      final idx = listAvailable.map((e) => e['outletId']).toList().indexOf(e['id']);

                      final body = {
                        "id": idx == -1 ? null : listAvailable[idx]['id'],
                        "companyId": e['companyId'],
                        "outletId": e['id'],
                        "productId": ProductVal.mapData.value.val['id'],
                        "isActive": val
                      };

                      body.removeWhere((k, v) => v == null);

                      final res = await Rot.productUpdateOutletPost(body: {"data": jsonEncode(body)});
                      if (res.statusCode == 201) {
                        reloadListAvailable.toggle();
                        SmartDialog.showToast("success");
                      } else {
                        SmartDialog.showToast(res.body);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
