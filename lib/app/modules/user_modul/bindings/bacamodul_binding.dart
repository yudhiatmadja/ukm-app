import 'package:get/get.dart';
import 'package:ukm_app/app/modules/user_modul/controllers/bacamodul_controller.dart';

class BacaModulBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BacamodulController>(
      () => BacamodulController(),
    );
  }
}
