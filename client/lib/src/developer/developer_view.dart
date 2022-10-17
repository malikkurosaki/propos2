import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class DeveloperView extends StatelessWidget {
  const DeveloperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) => SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Developer",
                style: TextStyle(fontSize: 24),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: media.isMobile ? Get.width : 460,
                  child: Column(
                    children: [],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
