import 'package:flutter/material.dart';
import 'package:propos/src/product/product_create.dart';
import 'package:propos/src/product/product_display.dart';
import 'package:propos/src/product/product_val.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Product extends StatelessWidget {
  const Product({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      child: ProductDisplay(),
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
