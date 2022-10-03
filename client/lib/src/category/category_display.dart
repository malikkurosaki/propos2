import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/category/category_val.dart';
import 'package:get/get.dart';

class CategoryDisplay extends StatelessWidget {
  const CategoryDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () {
            CategoryVal.isReload.value;
            return FutureBuilder<http.Response>(
              future: Rot.categoryListGet(),
              builder: (con, snap) {
                if (snap.connectionState != ConnectionState.done) return LinearProgressIndicator();

                if (snap.data!.statusCode == 200) {
                  Future.delayed(
                    Duration(microseconds: 1),
                    () => CategoryVal.listCategory.assignAll(
                      jsonDecode(snap.data!.body),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            );
          },
        ),
        Flexible(
          child: Obx(
            () => ListView(
              children: [
                ...CategoryVal.listCategory.map(
                  (element) => ListTile(
                    trailing: PopupMenuButton(
                      itemBuilder: (con) => [
                        PopupMenuItem(
                          onTap: () async {
                            final dat = await Rot.categoryRemoveDelete(query: "id=${element['id']}");
                            if (dat.statusCode == 201) {
                              SmartDialog.showToast("success");
                              CategoryVal.isReload.toggle();
                            }
                          },
                          value: "delete",
                          child: Text("Delete"),
                        ),
                        PopupMenuItem(
                          value: "edit",
                          child: Text("edit"),
                        )
                      ],
                    ),
                    title: Text(
                      element['name'].toString(),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
