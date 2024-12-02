import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../controllers/docs_controller.dart';

class DocsView extends StatefulWidget {
  @override
  _DocsViewState createState() => _DocsViewState();
}

class _DocsViewState extends State<DocsView> {
  final DocsController _controller = DocsController();
  String currentTab = 'Foto';
  bool isRecording = false;  // Track if recording is in progress

  @override
  void initState() {
    super.initState();
    _controller.requestPermissions();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xFF089E55),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Dokumentasi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Tab Navigation
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTab('Foto'),
                _buildTab('Video'),
                _buildTab('Audio'),
              ],
            ),
          ),

          Positioned(
            top: 150,
            left: 16,
            right: 16,
            child: Center(
              child: currentTab == 'Foto'
                  ? _controller.pickedFile != null
                  ? Image.file(
                File(_controller.pickedFile!.path),
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              )
                  : _buildEmptyMessage('Belum ada foto yang dipilih')
                  : currentTab == 'Video'
                  ? _controller.videoController != null &&
                  _controller.videoController!.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _controller.videoController!
                    .value.aspectRatio,
                child: VideoPlayer(_controller.videoController!),
              )
                  : _buildEmptyMessage('Belum ada video yang dipilih')
                  : currentTab == 'Audio'
                  ? _buildAudioStatus()
                  : Container(),
            ),
          ),


          Positioned(
            bottom: 80,
            left: 16,
            right: 16,
            child: Column(
              children: [
                if (currentTab == 'Foto') ...[
                  _buildActionButton('Ambil Foto', () async {
                    final photo = await _controller.takePhoto();
                    if (photo != null) {
                      setState(() {
                        _controller.pickedFile = photo;
                      });
                    }
                  }),
                ] else if (currentTab == 'Video') ...[
                  _buildActionButton('Rekam Video', () async {
                    final video = await _controller.recordVideo();
                    if (video != null) {
                      final videoController =
                      await _controller.initializeVideo(video.path);
                      setState(() {
                        _controller.pickedFile = video;
                        _controller.videoController = videoController;
                        _controller.videoController!.play();
                      });
                    }
                  }),
                ] else if (currentTab == 'Audio') ...[
                  _buildActionButton(
                    isRecording ? 'Stop Rekam Audio' : 'Rekam Audio',
                        () async {
                      if (isRecording) {
                        await _controller.stopRecording();
                      } else {
                        await _controller.recordAudio();
                      }
                      setState(() {
                        isRecording = !isRecording;
                      });
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentTab = title;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: currentTab == title ? Colors.green : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (currentTab == title)
            Container(
              margin: EdgeInsets.only(top: 4),
              height: 2,
              width: 50,
              color: Colors.green,
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyMessage(String message) {
    return Text(
      message,
      style: TextStyle(fontSize: 16, color: Colors.grey),
    );
  }

  Widget _buildAudioStatus() {
    return Center(
      child: Text(
        isRecording ? 'Sedang merekam...' : 'Klik untuk mulai rekam',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF089E55),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
