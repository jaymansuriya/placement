import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerPage extends StatefulWidget {
  final String pdfURL;
  final String topicName;
  const PDFViewerPage({Key? key, required this.pdfURL, required this.topicName})
      : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.deepPurple[500],
          title: Text(
            widget.topicName,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),
          ),
        ),
        body: Center(
            child: SfPdfViewer.network(widget.pdfURL,
                pageLayoutMode: PdfPageLayoutMode.continuous,
                scrollDirection: PdfScrollDirection.vertical)),
      ),
    );
  }
}
