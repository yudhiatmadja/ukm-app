import 'package:get/get.dart';
import 'package:ukm_app/app/data/models/usermodulmodel.dart';

class ModulController extends GetxController {
  // Observable for selected module
  var selectedModule = Rx<ModulModel?>(null); // Initialize it as null

  void setModule(ModulModel module) {
    selectedModule.value = module; // Set the selected module
  }
}
