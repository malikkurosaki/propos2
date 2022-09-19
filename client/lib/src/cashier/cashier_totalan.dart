import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:propos/pages.dart';
import 'package:propos/src/cashier/cashier_dialog_save.dart';
import 'package:propos/src/cashier/cashier_totalan_footer.dart';
import 'package:propos/src/cashier/cashier_totalan_header.dart';
import 'package:propos/src/cashier/cashier_totalan_main.dart';
import 'package:propos/src/cashier/casier_val.dart';
import 'package:propos/utils/img_def.dart';
import 'package:propos/utils/val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CashierTotalan extends StatelessWidget {
  const CashierTotalan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, media) {
        return Scaffold(
          body: Builder(
            builder: (context) {
              return SizedBox(
                width: media.isMobile ? Get.width : 500,
                child: Card(
                  child: Column(
                    children: [
                      CashierTotalanHeader(),
                      // _headerTotalan(media, CashierVal.lsTampungan),
                      // mulai list item
                      Flexible(
                        child:  CashierTotalanMain(),
                      ),
                      CashierTotalanFooter()
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
