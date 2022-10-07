import 'package:flutter/material.dart';
import 'package:propos/src/product/product_create.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:propos/src/product/product_view_main.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ProductVal.loadListOutlet();
    // ProductVal.loadListOutlet();
    return ResponsiveBuilder(
      builder: (context, media) {
        return SafeArea(
          child: Column(
            children: [
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      // child: _listDisplay(media),
                      // child: ProductDisplay(),
                      child: ProductViewMain(),
                    ),
                    // disini
                    Visibility(
                      visible: !media.isMobile,
                      child: Card(
                        child: Column(
                          // children: [Flexible(child: _create(media))],
                          children: [Flexible(child: ProductCreate())],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
