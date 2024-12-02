import 'package:get/get.dart';
import 'package:ukm_app/app/modules/user_modul/controllers/modul_controller.dart';

class ModulBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModulController>(
      () => ModulController(),
    );
  }
}
