import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:ukm_app/app/modules/Location/views/loc_view.dart';
import 'package:ukm_app/app/modules/Quiz_User/views/quizuser_view.dart';
import 'package:ukm_app/app/modules/Scoreboard/views/scoreboard_view.dart';
import 'package:ukm_app/app/modules/UserDashboard/views/webview_user.dart';
import 'package:ukm_app/app/modules/absen/views/absen_view.dart';
import 'package:ukm_app/app/modules/calender/views/calender_view.dart';
import 'package:ukm_app/app/modules/dokumentasi/views/docs_view.dart';
import 'package:ukm_app/app/modules/profile/views/profile_view.dart';
import 'package:ukm_app/app/modules/schedule/views/schedule_view.dart';
import 'package:ukm_app/app/modules/user_modul/views/modul_view.dart';
import '../controllers/user_controller.dart';

class HomepageUView extends StatefulWidget {
  const HomepageUView({Key? key}) : super(key: key);

  @override
  _HomepageUViewState createState() => _HomepageUViewState();
}

class _HomepageUViewState extends State<HomepageUView> {
  final SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _spokenText = '';
  bool _isSpeechEnabled = false;

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  void _initializeSpeech() async {
    _isSpeechEnabled = await _speech.initialize();
    setState(() {});
  }

  void _startListening() async {
    if (_isSpeechEnabled) {
      setState(() {
        _isListening = true;
      });
      _speech.listen(onResult: (result) {
        setState(() {
          _spokenText = result.recognizedWords;
        });
      });
    }
  }

  void _stopListening() {
    setState(() {
      _isListening = false;
    });
    _speech.stop();
  }

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ProfileView());
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30.0,
                            backgroundImage: AssetImage('assets/bg.png'),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                                    return Text(
                                      'Loading...',
                                      style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    );
                                  }
                                  var userData = snapshot.data?.data() as Map<String, dynamic>;
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
                              SizedBox(height: 5.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),

                // Search Bar with Speech to Text
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
                          controller: TextEditingController(text: _spokenText),
                          decoration: InputDecoration(
                            hintText: "Search",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(_isListening ? Icons.mic_off : Icons.mic),
                        onPressed: () {
                          if (_isListening) {
                            _stopListening();
                          } else {
                            _startListening();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),

                // Menu Items Grid
                GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    buildMenuItem(
                      context,
                      'Modul',
                      Icons.book,
                          () => Get.to(() => ModulScreen()),
                    ),
                    buildMenuItem(
                      context,
                      'Quiz',
                      Icons.question_answer,
                          () => Get.to(() => QuizUserView()),
                    ),
                    buildMenuItem(
                      context,
                      'Absen',
                      Icons.checklist,
                          () => Get.to(() => AbsensiPage()),
                    ),
                    buildMenuItem(
                      context,
                      'Schedule',
                      Icons.schedule,
                          () => Get.to(() => ScheduleView()),
                    ),
                    buildMenuItem(
                      context,
                      'Scoreboard',
                      Icons.leaderboard,
                          () => Get.to(() => ScoreboardPage()),
                    ),
                    buildMenuItem(
                      context,
                      'About HW',
                      Icons.info,
                          () => Get.to(() => SejarahView()),
                    ),
                    buildMenuItem(
                        context,
                        'Docs',
                        Icons.camera,
                            () => Get.to(() => DocsView())
                    ),
                    buildMenuItem(
                        context,
                        'Saya Tersesat',
                        Icons.maps_home_work_rounded,
                            () => Get.to(() => LokasiView())
                    )
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
        onTap: (index) {
          switch (index) {
            case 0:
              Get.to(() => HomepageUView());
              break;
            case 1:
              break;
            case 2:
              Get.to(() => CalenderView());
              break;
            case 3:
              Get.to(() => ProfileView());
              break;
          }
        },
      ),
    );
  }

  Widget buildMenuItem(
      BuildContext context, String title, IconData icon, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF009D44),
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
