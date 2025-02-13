import 'package:flutter/material.dart';
import 'pdfgenerator.dart'; // Importa la clase PdfGenerator

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generador de PDF")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            PdfGenerator.generatePdf(); // Llama a la función para generar y abrir el PDF
          },
          child: Text("Generar PDF"),
        ),
      ),
    );
  }
}
