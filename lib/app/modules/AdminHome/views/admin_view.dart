import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ukm_app/app/modules/Quiz/views/quiz_view.dart';
import 'package:ukm_app/app/modules/admin_absen/views/admin_absen_view.dart';
import 'package:ukm_app/app/modules/kegiatan_admin/views/addkegiatan_view.dart';
import 'package:ukm_app/app/modules/modulpage/views/add_module_view.dart';
import 'package:ukm_app/app/modules/profile/views/profile_view.dart';
import 'package:ukm_app/app/modules/struktur/views/struktur_view.dart';

import '../controllers/admin_controller.dart';

class HomepageAView extends GetView<HomepageAController> {
  const HomepageAView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(221, 165, 35, 0.4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar dan nama pengguna (ditambahkan GestureDetector)
                GestureDetector(
                  onTap: () {
                    Get.to(ProfileView()); // Navigasi ke halaman profil
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage(
                            'assets/bg.png'), // Ganti dengan link atau asset gambar user
                      ),
                      SizedBox(width: 10.0),
                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting ||
                              !snapshot.hasData) {
                            return Text(
                              'Loading...',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            );
                          }
                          var userData =
                          snapshot.data?.data() as Map<String, dynamic>;
                          String userName = userData['name'] ?? 'User';

                          return Text(
                            userName,
                            style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),

                // Search bar
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.black54),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(Icons.mic, color: Colors.black54),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),

                // Grid Menu
                GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                   
                    buildMenuItem(context, 'Modul', Icons.book, ModuleAdd()),
                    buildMenuItem(
                        context, 'Absen', Icons.checklist, AbsenAdminPage()),
                    buildMenuItem(
                        context, 'Schedule', Icons.schedule, AddEventPage()),
                    buildMenuItem(context, 'Quiz', Icons.lightbulb, QuizView()),
                    buildMenuItem(context, 'Struktur', Icons.account_tree,
                        StrukturScreen()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }

  // Fungsi untuk membuat item menu
  Widget buildMenuItem(
      BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        Get.to(page); // Navigasi ke halaman baru
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF009D44), // Warna hijau
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40.0),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
