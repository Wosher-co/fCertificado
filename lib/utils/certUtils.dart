import 'dart:io';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:qrscan/qrscan.dart' as scanner;

class CertUtils {
  static Future<String?> imageFromPdfFile(String pdfFilePath) async {
    final document = await PdfDocument.openFile(pdfFilePath);
    final page = await document.getPage(1);
    final pageImage = await page.render(
        width: page.width, height: page.height, format: PdfPageFormat.JPEG);

    final appDir = await syspaths.getTemporaryDirectory();
    File file = File('${appDir.path}/pdftemp.jpg');
    if (await file.exists()) {
      await file.delete();
    }
    await file.writeAsBytes(pageImage!.bytes);

    await page.close();
    return file.path;
  }

  static Future<String> getQRData(String pdfImagePath) async {
    // Get data from qr code imageBytes
    String barcode = await scanner.scanPath(pdfImagePath);
    print(barcode);

    return barcode;
  }

  static Future<String> getPdfData(String filePath) async {
    final pdfImageFilePath = await imageFromPdfFile(filePath);
    if (pdfImageFilePath == null) return "";
    final qrData = await getQRData(pdfImageFilePath);
    await File(pdfImageFilePath).delete();
    return qrData;
  }

  static Future<String> getImageData(String imageFilePath) async {
    final qrData = await getQRData(imageFilePath);
    await File(imageFilePath).delete();
    return qrData;
  }
}
