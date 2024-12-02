import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ukm_app/app/data/models/module_model.dart';
import 'package:ukm_app/app/modules/modulpage/controllers/module_controller.dart';
import 'package:ukm_app/app/modules/modulpage/widgets/modul_card.dart';

class ModuleAdd extends StatelessWidget {
  final ModuleController controller = Get.put(ModuleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modules'),
        backgroundColor: Colors.green[800],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.modules.length,
          itemBuilder: (context, index) {
            return ModuleCard(
              module: controller.modules[index],
              onEdit: () {
                Get.dialog(
                  AddModuleDialog(module: controller.modules[index]),
                );
              },
              onDelete: () {
                controller.deleteModule(controller.modules[index].id);
              },
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          onPressed: () {
            Get.dialog(AddModuleDialog());
          },
          backgroundColor: Colors.green[600],
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class AddModuleDialog extends StatelessWidget {
  final ModuleController controller = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final RxString selectedDate = ''.obs;

  final ModuleModel? module;

  AddModuleDialog({this.module}) {
    if (module != null) {
      titleController.text = module!.title;
      authorController.text = module!.author;
      descriptionController.text = module!.description;
      selectedDate.value = module!.date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(module == null ? 'Add Module' : 'Edit Module',
          style: TextStyle(color: Colors.green[800])),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Judul',
                  labelStyle: TextStyle(color: Colors.green[600]),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[800]!),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: authorController,
                decoration: InputDecoration(
                  labelText: 'Penulis',
                  labelStyle: TextStyle(color: Colors.green[600]),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[800]!),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  labelStyle: TextStyle(color: Colors.green[600]),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[800]!),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Tidak boleh kosong' : null,
              ),
              Obx(
  () => TextButton.icon(
    onPressed: () async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      
      // Add null check for pickedDate before accessing its properties
      if (pickedDate != null) {
        selectedDate.value =
            '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
      }
    },
    icon: Icon(Icons.calendar_today, color: Colors.green[800]),
    label: Text(
        selectedDate.value.isNotEmpty
            ? selectedDate.value
            : 'Pilih Tanggal',
        style: TextStyle(color: Colors.green[800])),
  ),
),

            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate() &&
                selectedDate.value.isNotEmpty) {
              if (module == null) {
                controller.addModule(
                  titleController.text,
                  authorController.text,
                  descriptionController.text,
                  selectedDate.value,
                );
              } else {
                controller.editModule(
                    module!.id,
                    ModuleModel(
                      id: module!.id,
                      title: titleController.text,
                      author: authorController.text,
                      description: descriptionController.text,
                      date: selectedDate.value,
                    ));
              }
              Get.back();
            }
          },
          child: Text(module == null ? 'Simpan' : 'Update',
              style: TextStyle(color: Colors.green[600])),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Batal', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
