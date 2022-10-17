import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:propos/pages.dart';
import 'package:propos/src/developer/developer_val.dart';
import 'package:propos/utils/val.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ResponsiveBuilder(
        builder: (context, media) {
          return SafeArea(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  Row(
                    children: [
                      BackButton(
                        onPressed: () => Get.toNamed(Pages.homePage().route),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "Developer Page",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      )
                    ],
                  ),
                  Obx(() => SizedBox(
                        width: media.isMobile ? Get.width : 460,
                        child: Card(
                          child: Column(
                            children: [
                              CheckboxListTile(
                                title: Text("Show Id"),
                                value: DeveloperVal.showId.value.val,
                                onChanged: (val) {
                                  DeveloperVal.showId.value.val = val!;
                                  DeveloperVal.showId.refresh();
                                },
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
