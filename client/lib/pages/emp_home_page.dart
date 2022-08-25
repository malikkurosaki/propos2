import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EmpHomePage extends StatelessWidget {
  const EmpHomePage({
    Key ? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, media) {
      return SafeArea(
        child: ListView(
          children: [
            Text('Hello World'),
          ],
        ),
      );
    });
  }
}