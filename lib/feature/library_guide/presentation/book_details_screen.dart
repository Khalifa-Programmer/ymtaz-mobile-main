import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yamtaz/core/helpers/shared_functions.dart';
import 'package:yamtaz/feature/library_guide/data/model/books_response.dart';

import '../../../core/widgets/pdf_screen.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key, required this.data, required this.title});

  final Book data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<File>(
        future: loadNetwork(data.file!),
        // Assuming data.file contains the URL of the PDF
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text("حدث خطأ اثناء تحميل الملف")); // Show error message
          } else if (snapshot.hasData) {
            File pdf = snapshot.data!;
            return PdfViewerPage(pdfFile: pdf, title: title, url: data.file!);
          } else {
            return const Center(
                child: Text("حدث خطأ اثناء تحميل الملف")); // Handle empty state
          }
        },
      ),
    );
  }

  // Function to save the PDF file to the Downloads directory on Android or prompt to save on iOS
  Future<void> saveToFile(File file, String title, BuildContext context) async {
    if (Platform.isAndroid) {
      // Request permissions to access external storage
      if (await _requestPermissions(context)) {
        try {
          // Save to the public Downloads directory
          String newFilePath =
              path.join('/storage/emulated/0/Download', '$title.pdf');

          // Copy the file to the new location
          File newFile = await file.copy(newFilePath);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("File saved to Downloads: $newFilePath"),
            ),
          );

          // Try opening the file
          _openFile(newFile);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to save file: $e"),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Permission to access storage was denied."),
          ),
        );
      }
    } else if (Platform.isIOS) {
      // For iOS, prompt the user with the "Save to Files" dialog
      try {
        await Share.shareXFiles([XFile(file.path)],
            text: 'Save $title.pdf to your Files app.');
      } catch (e) {
        print("Error saving file: $e");
      }
    }
  }

  // Function to request storage permissions on Android
  Future<bool> _requestPermissions(BuildContext context) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (status.isDenied || status.isPermanentlyDenied) {
        // If permission is denied or permanently denied, show a dialog
        _showPermissionDialog(context);
      }
    }
    return status.isGranted;
  }

  // Function to show a dialog to open app settings
  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Storage Permission Required"),
          content: Text(
              "This app needs storage access to save files. Please grant the permission in the app settings."),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Open Settings"),
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

  // Function to open the saved file
  void _openFile(File file) {
    // Here you can use any plugin like open_file or intent to open the file
    // This is a placeholder for the actual implementation
    print("File saved and ready to open: ${file.path}");
    // Example using open_file package:
    // OpenFile.open(file.path);
  }

  // Function to share the PDF file
  Future<void> shareFile(File file) async {
    try {
      await Share.shareXFiles([XFile(file.path)], text: 'Check out this PDF!');
    } catch (e) {
      print("Error sharing file: $e");
    }
  }
}
