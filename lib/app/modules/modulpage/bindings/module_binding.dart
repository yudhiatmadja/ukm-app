import 'package:get/get.dart';
import 'package:ukm_app/app/modules/modulpage/controllers/module_controller.dart';

class ModuleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModuleController>(
      () => ModuleController(),
    );
  }
}
