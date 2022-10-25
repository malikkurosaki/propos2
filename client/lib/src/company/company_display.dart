import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:propos/rot.dart';
import 'package:propos/src/company/company_create.dart';
import 'package:propos/src/company/company_edit.dart';
import 'package:propos/src/company/company_val.dart';
import 'package:propos/src/developer/developer_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CompanyDisplay extends StatelessWidget {
  const CompanyDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, media) {
      return Scaffold(
        floatingActionButton: !media.isMobile
            ? null
            : FloatingActionButton(
                onPressed: () {
                  showBottomSheet(
                    context: context,
                    builder: (context) => CompanyCreate(),
                  );
                },
                child: Icon(Icons.add),
              ),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                Obx(
                  () {
                    CompanyVal.reload.value;
                    return SizedBox(
                      height: 4,
                      child: FutureBuilder<http.Response>(
                        future: Rot.companyListCompanyGet(),
                        builder: (con, snap) {
                          if (!snap.hasData) return LinearProgressIndicator();
                          () async {
                            if (snap.data!.statusCode == 200) {
                              await 0.1.delay();
                              CompanyVal.listCompany.value.val = jsonDecode(snap.data!.body);
                              CompanyVal.listCompany.refresh();
                            }
                          }();
                          return Container();
                        },
                      ),
                    );
                  },
                ),
                Obx(
                  () => CompanyVal.listCompany.value.val.isEmpty
                      ? Container()
                      : Column(
                          children: [
                            ...CompanyVal.listCompany.value.val.map(
                              (e) => ListTile(
                                onTap: () {
                                  CompanyVal.mapData.assignAll(e);
                                  showBottomSheet(
                                    context: context,
                                    builder: (context) => CompanyEdit(),
                                  );
                                },
                                leading: Text((CompanyVal.listCompany.value.val.indexOf(e) + 1).toString()),
                                title: Row(
                                  children: [
                                    Text(e['name'].toString()),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.check_box,
                                  color: e['isActive'] ? Colors.green : Colors.grey,
                                ),
                                subtitle: !DeveloperVal.showId.value.val ? null : Text(e['id'].toString()),
                              ),
                            )
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
