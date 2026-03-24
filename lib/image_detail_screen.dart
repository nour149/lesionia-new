import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageDetailScreen extends StatelessWidget {
  final List<int> imageBytes;
  final String datemed;
  final String idsample;
  final double accuarcy;
  final String classid;

  const ImageDetailScreen({
    Key? key,
    required this.imageBytes,
    required this.datemed,
    required this.idsample,
    required this.accuarcy,
    required this.classid,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = Uint8List.fromList(imageBytes);

    return Scaffold(
      appBar: AppBar(title: Text("Image Details")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.memory(image, height: 300, width: 300, fit: BoxFit.cover),
            SizedBox(height: 20),
            Text("Check-up DATE: $datemed", style: TextStyle(fontSize: 16)),
            Text("Sample ID: $idsample", style: TextStyle(fontSize: 16)),
            Text("Accuarcy : $accuarcy",style: TextStyle(fontSize:16)),
            Text("classid : $classid", style:TextStyle(fontSize:16)),


            SizedBox(height: 20),

          ]
        ),
      ),
    );
  }
}
