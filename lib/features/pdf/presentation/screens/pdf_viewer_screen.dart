import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/storage/history_service.dart';

class PdfViewerScreen extends StatelessWidget {
  final String pdfUrl;
  final String title;

  const PdfViewerScreen({super.key, required this.pdfUrl, required this.title});

  Future<void> openPdf() async {
    final Uri url = Uri.parse(pdfUrl);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('No se pudo abrir el PDF');
    }
  }

  @override
  Widget build(BuildContext context) {
    HistoryService.addHistory(title, 'Documento Clínico');

    openPdf();

    return Scaffold(
      appBar: AppBar(title: Text(title)),

      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
