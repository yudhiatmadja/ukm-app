import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AbsenAdminPage extends StatefulWidget {
  @override
  _AbsenAdminPageState createState() => _AbsenAdminPageState();
}

class _AbsenAdminPageState extends State<AbsenAdminPage> {
  final CollectionReference attendanceCollection =
      FirebaseFirestore.instance.collection('attendances');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Presensi'),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: attendanceCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final attendances = snapshot.data!.docs.map((doc) {
            return Attendance(
              doc['name'],
              doc['isPresent'],
              doc.id,
            );
          }).toList();
          return ListView.builder(
            itemCount: attendances.length,
            itemBuilder: (context, index) {
              return attendanceRow(attendances[index]);
            },
          );
        },
      ),
    );
  }

  Widget attendanceRow(Attendance attendance) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/profile.jpg'),
        ),
        title: Text(attendance.name),
        subtitle: Text(attendance.isPresent ? 'Hadir' : 'Absen'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                editAttendance(attendance);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteAttendance(attendance);
              },
            ),
          ],
        ),
      ),
    );
  }

  void editAttendance(Attendance attendance) {
    TextEditingController nameController =
        TextEditingController(text: attendance.name);
    bool isPresent = attendance.isPresent;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Attendance'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hadir'),
                  Switch(
                    value: isPresent,
                    onChanged: (value) {
                      setState(() {
                        isPresent = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  await attendanceCollection
                      .doc(attendance.id)
                      .update({'name': nameController.text, 'isPresent': isPresent});
                  Navigator.of(context).pop();
                } catch (e) {
                  print("Failed to update attendance: $e");
                }
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void deleteAttendance(Attendance attendance) async {
    try {
      await attendanceCollection.doc(attendance.id).delete();
    } catch (e) {
      print("Failed to delete attendance: $e");
    }
  }
}

class Attendance {
  String name;
  bool isPresent;
  String id;

  Attendance(this.name, this.isPresent, this.id);
}
