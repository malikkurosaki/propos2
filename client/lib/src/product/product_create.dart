import 'dart:convert';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:propos/src/product/product_create_primary.dart';
import 'package:propos/src/product/product_create_submit.dart';
import 'package:propos/src/product/product_create_with_image.dart';
import 'package:propos/src/product/product_create_with_stock.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:propos/utils/router_api.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:get/get.dart';

class ProductCreate extends StatelessWidget {
  // ProductCreate(
  //     {Key? key,
  //     required this.media,
  //     required this.lsCompany,
  //     required this.productImage,
  //     required this.isLoadingCreateButton})
  //     : super(key: key);

  // final SizingInformation media;
  // final RxList<dynamic> lsCompany;
  // final RxMap<String, dynamic> productImage;
  // final RxBool isLoadingCreateButton;

  _onLoad() {
    RouterApi.productCreateSelect().getData().then(
      (value) {
        if (value.statusCode == 200) {
          ProductVal.lsCompany.assignAll(jsonDecode(value.body));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final menu = [
      {"title": "Primary", "widget": const ProductCreatePrimary()},
      {
        "title": "Include Image",
        "widget": const ProductCreateWithImage()
      },
      {"title": "Include Stock", "widget": const ProductCreateWithStock()}
    ];
    _onLoad();
    return ResponsiveBuilder(builder: (context, media) {
      return SizedBox(
        width: media.isMobile ? Get.width : 430,
        // height: Get.height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Create Product",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  Flexible(
                    child: ContainedTabBarView(
                      tabs: [...menu.map((e) => ListTile(title: Text(e['title'].toString())))],
                      views: [
                        ...menu.map(
                          (e) => (e['widget'] as Widget),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // _submit(media)
            const ProductCreateSubmit()
          ],
        ),
      );
    });
  }
}
