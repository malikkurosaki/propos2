import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propos/pages.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get_storage/get_storage.dart';

class BusinessDetailPage extends StatelessWidget {
  BusinessDetailPage({Key? key}) : super(key: key);

  _onLoad() async {
    if (Get.arguments == null) {
      await 0.1.delay();
      Get.offNamed(Pages.homePage().route);
    }
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return ResponsiveBuilder(builder: (context, media) {
      return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(),
            Text(Get.arguments.toString()),
          ],
        ),
      );
    });
  }
}
