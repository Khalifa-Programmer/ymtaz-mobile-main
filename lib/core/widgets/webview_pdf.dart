import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PdfWebView extends StatefulWidget {
  const PdfWebView({super.key, required this.link});

  final String link;

  @override
  State<PdfWebView> createState() => _PdfWebViewState();
}

class _PdfWebViewState extends State<PdfWebView> {
  bool isImage = false;
  bool isPdf = false;

  @override
  void initState() {
    super.initState();
    _checkFileType();
  }

  void _checkFileType() {
    final lowerCaseLink = widget.link.toLowerCase();
    if (lowerCaseLink.endsWith('.pdf')) {
      isPdf = true;
    } else if (lowerCaseLink.endsWith('.jpg') ||
        lowerCaseLink.endsWith('.jpeg') ||
        lowerCaseLink.endsWith('.png') ||
        lowerCaseLink.endsWith('.gif') ||
        lowerCaseLink.endsWith('.webp')) {
      isImage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "عرض المرفقات",
          style: TextStyles.cairo_14_bold.copyWith(
            color: appColors.black,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isPdf) {
      return SfPdfViewer.network(
        widget.link,
        onDocumentLoadFailed: (details) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل تحميل ملف PDF: ${details.description}')),
          );
        },
      );
    } else if (isImage) {
      return PhotoView(
        imageProvider: NetworkImage(widget.link),
        backgroundDecoration: const BoxDecoration(color: Colors.white),
        loadingBuilder: (context, event) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Text('فشل تحميل الصورة'),
        ),
      );
    } else {
      // Fallback to WebView for other types
      return InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.link)),
      );
    }
  }
}

