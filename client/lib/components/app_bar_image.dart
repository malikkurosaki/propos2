import 'package:flutter/material.dart';
import 'package:propos/utils/img_def.dart';

class AppBarImage extends StatelessWidget {
  const AppBarImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 100, child: ImgDef.homeHeader(fit: BoxFit.cover, width: double.infinity));
  }
}
