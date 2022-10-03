import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propos/pages.dart';

final key = {
  "apiKey": "AIzaSyAfACNHRoyIvX4nct4juVabZDgwEDKQ6jY",
  "appId": "1:27222609089:web:bf85a0777451fb17da9840",
  "messagingSenderId": "27222609089",
  "projectId": "malikkurosaki1985",
  "name": "percobaan",
  "authDomain": "malikkurosaki1985.firebaseapp.com"
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.native,
      initialRoute: "/",
      getPages: Pages.listPage,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
    );
  }
}
