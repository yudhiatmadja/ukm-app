import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ukm_app/app/data/models/module_model.dart';

class ModuleController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxList<ModuleModel> modules = <ModuleModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchModules();
  }

  void fetchModules() {
    firestore.collection('modules').snapshots().listen((snapshot) {
      modules.value = snapshot.docs
          .map((doc) =>
              ModuleModel.fromJson(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> addModule(
      String title, String author, String description, String date) async {
    await firestore.collection('modules').add({
      'judul': title,
      'penulis': author,
      'deskripsi': description,
      'date': date,
    });
  }

  Future<void> editModule(String docId, ModuleModel updatedModule) async {
    await firestore
        .collection('modules')
        .doc(docId)
        .update(updatedModule.toJson());
  }

  Future<void> deleteModule(String docId) async {
    await firestore.collection('modules').doc(docId).delete();
  }
}
