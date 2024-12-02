import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../controllers/addkegiatan_controller.dart';
import 'event_card.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final AddkegiatanController _eventController = AddkegiatanController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _currentAddress = '';
  Position? _currentPosition;

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Layanan lokasi tidak diaktifkan')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Izin lokasi ditolak')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Izin lokasi ditolak secara permanen')),
      );
      return;
    }

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });

    _getAddressFromLatLng(position);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final place = placemarks[0];
      setState(() {
        _currentAddress = "${place.street}, ${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _showEventDialog({int? index}) {
    String name = index != null ? _eventController.events[index].name : '';
    String location =
    index != null ? _eventController.events[index].location : _currentAddress;
    String description =
    index != null ? _eventController.events[index].description : '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index != null ? 'Edit Kegiatan' : 'Tambah Kegiatan'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Nama Kegiatan'),
                  onChanged: (value) {
                    name = value;
                  },
                  controller: TextEditingController(text: name),
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    'Tanggal: ${_eventController.formatDate(_selectedDate)}',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                TextButton(
                  onPressed: () => _selectTime(context),
                  child: Text(
                    'Jam: ${_eventController.formatTime(_selectedTime, context)}',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    await _getCurrentLocation();
                  },
                  child: Text("Cari Lokasi Saat Ini"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
                if (location.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Lokasi: $_currentAddress',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                TextField(
                  decoration: InputDecoration(labelText: 'Deskripsi'),
                  onChanged: (value) {
                    description = value;
                  },
                  controller: TextEditingController(text: description),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (name.isNotEmpty) {
                  setState(() {
                    if (index != null) {
                      // Update existing event
                      _eventController.updateEvent(
                        index,
                        name,
                        _selectedDate,
                        _selectedTime,
                        _currentAddress,
                        description,
                      );
                    } else {
                      // Add new event
                      _eventController.addEvent(
                        name,
                        _selectedDate,
                        _selectedTime,
                        _currentAddress,
                        description,
                      );
                    }
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Simpan', style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Kegiatan'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _eventController.events.length,
              itemBuilder: (context, index) {
                final event = _eventController.events[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  elevation: 4,
                  child: EventCard(
                    event: {
                      'name': event.name,
                      'date': _eventController.formatDate(event.date),
                      'time': _eventController.formatTime(event.time, context),
                      'location': event.location,
                      'description': event.description,
                    },
                    onEdit: () => _showEventDialog(index: index),
                    onDelete: () {
                      setState(() {
                        _eventController.deleteEvent(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () => _showEventDialog(),
            child: Icon(Icons.add, size: 30),
            backgroundColor: Colors.green,
            tooltip: 'Tambah Kegiatan',
          ),
        ],
      ),
    );
  }
}
