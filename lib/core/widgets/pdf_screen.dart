import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../config/themes/styles.dart';
import '../constants/colors.dart';

class PdfViewerPage extends StatefulWidget {
  final File pdfFile;
  final String title;
  final String url;

  const PdfViewerPage({
    super.key,
    required this.pdfFile,
    required this.title,
    required this.url,
  });

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late PdfViewerController _pdfViewerController;
  bool isPageIndicatorVisible = true;
  Timer? _hideTimer;
  double _currentZoomLevel = 1.0;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    _hideTimer?.cancel();
    super.dispose();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 2), () {
      setState(() {
        isPageIndicatorVisible = false;
      });
    });
  }

  // إضافة أزرار التحكم بالزوم
  Widget _buildZoomControls() {
    return Positioned(
      left: 16,
      bottom: 16,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.zoom_in, color: Colors.white),
              onPressed: () {
                _pdfViewerController.zoomLevel =
                    (_currentZoomLevel + 0.25).clamp(0.25, 3.0);
                setState(() {
                  _currentZoomLevel = _pdfViewerController.zoomLevel;
                });
              },
            ),
            Text(
              '${(_currentZoomLevel * 100).toInt()}%',
              style: const TextStyle(color: Colors.white),
            ),
            IconButton(
              icon: const Icon(Icons.zoom_out, color: Colors.white),
              onPressed: () {
                _pdfViewerController.zoomLevel =
                    (_currentZoomLevel - 0.25).clamp(0.25, 3.0);
                setState(() {
                  _currentZoomLevel = _pdfViewerController.zoomLevel;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyles.cairo_14_bold.copyWith(
            color: appColors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              saveToFile(widget.pdfFile, widget.title, context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              shareFile(widget.pdfFile);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SfPdfViewer.file(
            widget.pdfFile,
            controller: _pdfViewerController,
            onZoomLevelChanged: (PdfZoomDetails details) {
              setState(() {
                _currentZoomLevel = details.newZoomLevel;
              });
              isPageIndicatorVisible = true;
              _startHideTimer();
            },
            onPageChanged: (PdfPageChangedDetails details) {
              setState(() {
                isPageIndicatorVisible = true;
              });
              _startHideTimer();
            },
          ),
          if (isPageIndicatorVisible)
            Positioned(
              right: 16,
              bottom: 16,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Page ${_pdfViewerController.pageNumber} of ${_pdfViewerController.pageCount}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Function to save the PDF file
  Future<void> saveToFile(File file, String title, BuildContext context) async {
    if (Platform.isAndroid) {
      if (await _requestPermissions(context)) {
        try {
          String newFilePath =
              path.join('/storage/emulated/0/Download', '$title.pdf');
          File newFile = await file.copy(newFilePath);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("File saved to Downloads: $newFilePath")),
          );

          _openFile(newFile);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to save file: $e")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Permission to access storage was denied.")),
        );
      }
    } else if (Platform.isIOS) {
      try {
        await Share.shareXFiles(
          [XFile(file.path)],
          text: 'Save $title.pdf to your Files app.',
        );
      } catch (e) {
        print("Error saving file: $e");
      }
    }
  }

  Future<bool> _requestPermissions(BuildContext context) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (status.isDenied || status.isPermanentlyDenied) {
        _showPermissionDialog(context);
      }
    }
    return status.isGranted;
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Storage Permission Required"),
          content: const Text(
              "This app needs storage access to save files. Please grant the permission in the app settings."),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Open Settings"),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _openFile(File file) {
    print("File saved and ready to open: ${file.path}");
  }

  Future<void> shareFile(File file) async {
    try {
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Check out this PDF!',
      );
    } catch (e) {
      print("Error sharing file: $e");
    }
  }
}
