import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ExportService {
  Future<void> exportToPDF(GlobalKey key) async {
    final doc = pw.Document();
    final image = await _captureWidgetAsImage(key);
    if (image != null) {
      final pdfImage = pw.MemoryImage(image);
      doc.addPage(pw.Page(build: (pw.Context context) => pw.Center(child: pw.Image(pdfImage))));
      await Printing.layoutPdf(onLayout: (format) => doc.save());
    }
  }

  Future<Uint8List?> _captureWidgetAsImage(GlobalKey key) async {
    try {
      final boundary = key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      return null;
    }
  }
}
