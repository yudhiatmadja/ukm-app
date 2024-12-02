import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ukm_app/app/modules/Location/bindings/loc_binding.dart';
// import 'package:ukm_app/app/modules/AdminHome/bindings/admin_binding.dart';
// import 'package:ukm_app/app/modules/UserDashboard/bindings/user_binding.dart';
import 'package:ukm_app/firebase_options.dart';

import 'app/modules/login/bindings/login_bindings.dart';
import 'app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await GetStorage.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Error during initialization: $e");
  }

  runApp(
    GetMaterialApp(
      title: "Hizbul Wathan App",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: LoginBinding(),
    ),
  );
}

