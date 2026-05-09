import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../library/domain/entities/document_entity.dart';

class PdfReaderScreen extends StatelessWidget {
  final DocumentEntity document;

  const PdfReaderScreen({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 0,

        title: Text(
          document.title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(color: Colors.black),

        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),

          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),

          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),

      body: SfPdfViewer.asset(
        document.filePath,

        canShowScrollHead: true,
        canShowScrollStatus: true,

        enableDoubleTapZooming: true,
        enableTextSelection: true,
      ),
    );
  }
}
