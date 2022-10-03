import 'package:flutter/material.dart';
import 'package:propos/pages.dart';
import 'package:propos/utils/img_def.dart';
import 'package:propos/utils/val.dart';
import 'package:propos/utils/vl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  _onLoad() async {
    await 1.delay();

    if (Vl.userId.val.isEmpty) {
      Get.offAllNamed(Pages.loginPage().route);
    } else {
      Get.offAllNamed(Pages.homePage().route);
    }
  }

  @override
  Widget build(BuildContext context) {
    _onLoad();
    return ResponsiveBuilder(builder: (context, media) {
      return SafeArea(
        child: Material(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ImgDef.probusSystem(),
            ),
          ),
        ),
      );
    });
  }
}
