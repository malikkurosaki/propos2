import 'dart:convert';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:propos/rot.dart';
import 'package:propos/src/product/product_create_primary.dart';
import 'package:propos/src/product/product_create_submit.dart';
import 'package:propos/src/product/product_create_with_image.dart';
import 'package:propos/src/product/product_create_with_stock.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:propos/utils/router_api.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class ProductCreate extends StatelessWidget {
  const ProductCreate({Key? key}) : super(key: key);
  _onLoad() async {
    final res = await Rot.globalCodGet();
    final result = jsonDecode(res.body) as Map;

    if (ProductVal.mapBodyCreate.value.val['ProductOutlet'] == null) {
      final data = ProductVal.mapBodyCreate.value.val;
      data['ProductOutlet'] = {
        "createMany": {
          "data": [
            {"outletId": result['Outlet']['id']}
          ]
        }
      };

      ProductVal.mapBodyCreate.value.val = data;
      ProductVal.mapBodyCreate.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final menu = [
    //   {
    //     "title": "Primary",
    //     "widget": const ProductCreatePrimary(),
    //   },
    //   {
    //     "title": "Include Image",
    //     "widget": const ProductCreateWithImage(),
    //   },
    //   {
    //     "title": "Include Stock",
    //     "widget": const ProductCreateWithStock(),
    //   }
    // ];
    _onLoad();
    return ResponsiveBuilder(
      builder: (context, media) {
        return SizedBox(
          width: media.isMobile ? Get.width : 430,
          // height: Get.height * 0.8,
          child: Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: media.isMobile ? BackButton() : null,
                  title: Text(
                    "Create Product",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [ProductCreatePrimary(), ProductCreateWithImage(), ProductCreateWithStock()],
                    ),
                  ),
                ),

                // Flexible(
                //   child: Column(
                //     children: [
                //       ContainedTabBarView(
                //         tabs: [...menu.map((e) => ListTile(title: Text(e['title'].toString())))],
                //         views: [
                //           ...menu.map(
                //             (e) => (e['widget'] as Widget),
                //           )
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

                // _submit(media)
                const ProductCreateSubmit()
              ],
            ),
          ),
        );
      },
    );
  }
}
