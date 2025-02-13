import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

class PdfGenerator {
  /// Obtiene la ruta del escritorio según el sistema operativo
  static Future<String> getDesktopPath() async {
    Directory? directory;
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      final homePath = Platform.environment['USERPROFILE'] ?? Platform.environment['HOME'];
      if (homePath == null) {
        print("❌ No se pudo obtener la ruta del usuario.");
        throw Exception("No se pudo determinar la ruta del escritorio.");
      }
      directory = Directory("$homePath/Desktop");
    } else {
      directory = await getApplicationDocumentsDirectory(); // Alternativa para móviles
    }

    print("📂 Ruta del escritorio: ${directory.path}");
    return directory.path;
  }

  /// Genera un PDF y lo guarda en el escritorio
  static Future<File> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              "¡Hola, este es un PDF generado en Flutter!",
              style: pw.TextStyle(fontSize: 24),
            ),
          );
        },
      ),
    );

    // Obtener la ruta del escritorio
    final path = await getDesktopPath();
    final file = File("$path/documento.pdf");

    try {
      // Guardar el PDF
      await file.writeAsBytes(await pdf.save());
      print("✅ PDF guardado en: ${file.path}");
    } catch (e) {
      print("❌ Error al guardar el PDF: $e");
    }

    return file;
  }

  /// Genera y abre el PDF automáticamente
  static Future<void> exportarPDF() async {
    final file = await generatePdf();
    if (await file.exists()) {
      print("✅ Abriendo archivo...");
      OpenFile.open(file.path);
    } else {
      print("❌ No se encontró el archivo para abrir.");
    }
  }
}
