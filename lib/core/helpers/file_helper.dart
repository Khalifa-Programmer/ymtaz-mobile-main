import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yamtaz/core/widgets/pdf_screen.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart'; // assuming resolveUrl or similar could be here, but I will put it inside this class for now

class FileHelper {
  FileHelper._();

  /// Standardizes URLs to use the current API domain and handles special characters.
  static String resolveUrl(String url) {
    if (url.isEmpty) return '';
    
    String resolved = url.trim();
    
    // Standardize domain to api.ymtaz.sa if it's ymtaz.sa (except for the placeholder)
    if (resolved.contains('ymtaz.sa') && !resolved.contains('api.ymtaz.sa') && !resolved.contains('person.png')) {
      resolved = resolved.replaceFirst('ymtaz.sa', 'api.ymtaz.sa');
    }
    
    // Ensure https or prepend base URL
    if (resolved.startsWith('http://')) {
      resolved = resolved.replaceFirst('http://', 'https://');
    } else if (!resolved.startsWith('http')) {
      // Handle relative paths
      final String baseUrl = 'https://api.ymtaz.sa';
      if (resolved.startsWith('/')) {
        resolved = '$baseUrl$resolved';
      } else {
        resolved = '$baseUrl/$resolved';
      }
    }
    
    // Encode spaces and special characters for a safe URI
    return Uri.encodeFull(resolved);
  }

  /// Gets a unique local path for a URL in the app's documents directory.
  static Future<String> getLocalPath(String url) async {
    final fileName = url.split('/').last.split('?').first;
    // Use hashCode for a unique prefix to avoid naming collisions
    final uniqueName = "cache_${url.hashCode.abs()}_$fileName";
    final directory = await getApplicationDocumentsDirectory();
    final ymtazDir = Directory("${directory.path}/ymtaz_files");
    if (!await ymtazDir.exists()) {
      await ymtazDir.create(recursive: true);
    }
    return "${ymtazDir.path}/$uniqueName";
  }

  /// Downloads a file if it doesn't already exist locally.
  static Future<File?> downloadIfNeeded(String url, {Function(double)? onProgress}) async {
    try {
      final resolvedUrl = resolveUrl(url);
      debugPrint("FileHelper: Resolved URL -> $resolvedUrl");
      
      final localPath = await getLocalPath(resolvedUrl);
      debugPrint("FileHelper: Local path -> $localPath");
      
      final file = File(localPath);

      if (await file.exists()) {
        final size = await file.length();
        if (size > 0) {
          debugPrint("FileHelper: Existing file found (size: $size bytes)");
          return file;
        } else {
          debugPrint("FileHelper: Found empty file, deleting and re-downloading.");
          await file.delete();
        }
      }

      debugPrint("FileHelper: Starting download...");
      final dio = Dio();
      await dio.download(
        resolvedUrl, 
        localPath,
        onReceiveProgress: (received, total) {
          if (total != -1 && onProgress != null) {
            onProgress(received / total);
          }
        },
      );
      
      if (await file.exists() && await file.length() > 0) {
        debugPrint("FileHelper: Download successful (size: ${await file.length()} bytes)");
        return file;
      }
      
      debugPrint("FileHelper: Download failed (file missing or empty after download)");
      return null;
    } catch (e) {
      debugPrint("FileHelper Error: $e");
      return null;
    }
  }

  /// High-level method to download and open a file based on its type.
  static Future<void> openFile(BuildContext context, String url, {String? title}) async {
    final resolvedUrl = resolveUrl(url);
    final fileName = resolvedUrl.split('/').last.split('?').first.toLowerCase();
    final extension = fileName.split('.').last;
    
    // Optional: add loading dialog here similar to previous implementation
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
      ),
    );

    try {
      final file = await downloadIfNeeded(resolvedUrl);
      
      if (context.mounted) Navigator.pop(context); // Close loading dialog

      if (file == null || !await file.exists()) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("عذراً، تعذر تحميل الملف. يرجى المحاولة لاحقاً.")),
          );
        }
        return;
      }

      if (extension == 'pdf') {
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewerPage(
                pdfFile: file,
                title: title ?? "عرض المستند",
                url: resolvedUrl,
              ),
            ),
          );
        }
      } else if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension)) {
        // For images, we already have a fullscreen mechanism in the detail screen,
        // but we could also implement a generic one here.
      } else {
        // Fallback for other files (maybe audio or unknown)
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("خطأ: $e")),
        );
      }
    }
  }
}
