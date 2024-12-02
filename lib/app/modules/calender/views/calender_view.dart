import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ukm_app/app/modules/schedule/views/schedule_view.dart';
import '../controllers/calender_controller.dart';

class CalenderView extends GetView<CalenderController> {
  const CalenderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(221, 165, 35, 0.4),
        title: const Text('Calendar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 383,
                height: 456,
                child: Stack(
                  children: [
                    Positioned(
                      left: 2,
                      top: 427,
                      child: SizedBox(
                        width: 215,
                        height: 29,
                        child: Text(
                          'Schedule',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26.90,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 237,
                      top: 119,
                      child: Container(
                        width: 43,
                        height: 43,
                        decoration: ShapeDecoration(
                          color: Color(0xFFFFC3C3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(54.92),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 52,
                      top: 298,
                      child: Container(
                        width: 43,
                        height: 43,
                        decoration: ShapeDecoration(
                          color: Color(0xFFFFC3C3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(54.92),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 174,
                      top: 119,
                      child: Container(
                        width: 43,
                        height: 43,
                        decoration: ShapeDecoration(
                          color: Color(0xFFFFC3C3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(54.92),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 237,
                      top: 238,
                      child: Container(
                        width: 43,
                        height: 43,
                        decoration: ShapeDecoration(
                          color: Color(0xFFFFC3C3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(54.92),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 1,
                      top: 0,
                      child: SizedBox(
                        width: 174,
                        height: 29,
                        child: Text(
                          'September',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26.90,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 2,
                      top: 73,
                      child: SizedBox(
                        width: 16,
                        height: 29,
                        child: Text(
                          'S',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 26.90,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 61,
                      top: 73,
                      child: SizedBox(
                        width: 22,
                        height: 29,
                        child: Text(
                          'M',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 26.90,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 126,
                      top: 73,
                      child: SizedBox(
                        width: 16,
                        height: 29,
                        child: Text(
                          'T',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 26.90,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 184,
                      top: 73,
                      child: SizedBox(
                        width: 24,
                        height: 29,
                        child: Text(
                          'W',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 26.90,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 250,
                      top: 73,
                      child: SizedBox(
                        width: 16,
                        height: 29,
                        child: Text(
                          'T',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 26.90,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 310,
                      top: 73,
                      child: SizedBox(
                        width: 14,
                        height: 29,
                        child: Text(
                          'F',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 26.90,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 367,
                      top: 73,
                      child: SizedBox(
                        width: 16,
                        height: 29,
                        child: Text(
                          'S',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 26.90,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 183,
                      child: Container(
                        width: 30,
                        height: 188,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '7',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '14',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '21',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '28',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 244,
                      top: 124,
                      child: Container(
                        width: 30,
                        height: 188,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '4',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '11',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '18',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '25',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 58,
                      top: 124,
                      child: Container(
                        width: 31,
                        height: 241,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '1',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '8',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '15',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '22',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '29',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 302,
                      top: 124,
                      child: Container(
                        width: 31,
                        height: 188,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '5',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '12',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '19',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '26',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 117,
                      top: 124,
                      child: Container(
                        width: 31,
                        height: 241,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '2',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '9',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '16',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '23',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '30',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 181,
                      top: 124,
                      child: Container(
                        width: 30,
                        height: 241,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '3',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '10',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '17',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '24',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                            const SizedBox(height: 26.90),
                            Text(
                              '31',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 26.90,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                                letterSpacing: -0.40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: 373,
                height: 302,
                child: Stack(
                  children: [
                    // First Event Container
                    Positioned(
                      left: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to Penjelajahan view
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScheduleView(),
                            ),
                          );
                        },
                        child: Container(
                          width: 373,
                          height: 63,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF3FFF9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.21),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 172,
                                height: 22,
                                child: Text(
                                  'Penjelajahan',
                                  style: TextStyle(
                                    color: Color(0xFF292929),
                                    fontSize: 16,
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                    letterSpacing: -0.24,
                                  ),
                                ),
                              ),
                              Text(
                                'Rabu, 3 September 2024',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                  letterSpacing: -0.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Second Event Container
                    Positioned(
                      left: 0,
                      top: 80,
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to Jambore view
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScheduleView(),
                            ),
                          );
                        },
                        child: Container(
                          width: 373,
                          height: 63,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF3FFF9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.21),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 172,
                                height: 22,
                                child: Text(
                                  'Jambore',
                                  style: TextStyle(
                                    color: Color(0xFF292929),
                                    fontSize: 16,
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                    letterSpacing: -0.24,
                                  ),
                                ),
                              ),
                              Text(
                                'Kamis, 4 September 2024',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                  letterSpacing: -0.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Third Event Container
                    Positioned(
                      left: 0,
                      top: 160,
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to Perkemahan Bakti view
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScheduleView(),
                            ),
                          );
                        },
                        child: Container(
                          width: 373,
                          height: 63,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF3FFF9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.21),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 172,
                                height: 22,
                                child: Text(
                                  'Perkemahan Bakti',
                                  style: TextStyle(
                                    color: Color(0xFF292929),
                                    fontSize: 16,
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                    letterSpacing: -0.24,
                                  ),
                                ),
                              ),
                              Text(
                                'Kamis, 18 September 2024',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                  letterSpacing: -0.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Fourth Event Container
                    Positioned(
                      left: 0,
                      top: 240,
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to Baris-Berbaris view
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScheduleView(),
                            ),
                          );
                        },
                        child: Container(
                          width: 373,
                          height: 63,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF3FFF9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.21),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 172,
                                height: 22,
                                child: Text(
                                  'Baris-Berbaris',
                                  style: TextStyle(
                                    color: Color(0xFF292929),
                                    fontSize: 16,
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                    letterSpacing: -0.24,
                                  ),
                                ),
                              ),
                              Text(
                                'Senin, 22 September 2024',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                  letterSpacing: -0.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
