import 'package:get/get.dart';

import '../controllers/quizuser_controller.dart';

class QuizUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizUserController>(
      () => QuizUserController(),
    );
  }
}
