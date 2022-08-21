import 'package:flutter/material.dart';
import 'package:propos/utils/img_def.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, media) {
      return SafeArea(
        child: ListView(
          children: [
            Row(
              children: [BackButton()],
            ),
            ImgDef.forgotPasswordIllustration65141418()
          ],
        ),
      );
    });
  }
}
