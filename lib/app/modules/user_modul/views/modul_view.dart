import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ukm_app/app/data/models/usermodulmodel.dart';
import '../controllers/modul_controller.dart';
import 'baca_modul.dart';

class ModulScreen extends StatelessWidget {
  final ModulController _modulController = Get.put(ModulController());

  Widget moduleCard(ModulModel module) {
    return GestureDetector(
      onTap: () {
        _modulController.setModule(module);
        Get.to(BacaModulScreen());
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: 10, horizontal: 16), // Add margin for spacing
        width: double.infinity, // Make it responsive
        height: 172,
        decoration: BoxDecoration(
          color: Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(10), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // Changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 15,
              top: 15,
              child: SizedBox(
                width: 250,
                child: Text(
                  module.title,
                  style: TextStyle(
                    color: Color(0xFF292929),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 15,
              top: 50,
              child: SizedBox(
                child: Text(
                  module.date,
                  style: TextStyle(
                    color: Color(0xFF696969),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 15,
              top: 70,
              child: SizedBox(
                width: 300,
                child: Text(
                  module.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF292929),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 15,
              bottom: 10,
              child: GestureDetector(
                onTap: () {
                  _modulController.setModule(module);
                  Get.to(BacaModulScreen());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.48),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Center(
                    child: Text(
                      'Baca',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Example module list for demonstration purposes
    final List<ModulModel> modules = [
      ModulModel(
        title: "Modul 1",
        date: "01 Jan 2024",
        description: "Description for Modul 1",
      ),
      ModulModel(
        title: "Modul 2",
        date: "02 Jan 2024",
        description: "Description for Modul 2",
      ),
      // Add more modules as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Modul List',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        children: modules.map(moduleCard).toList(),
      ),
    );
  }
}
