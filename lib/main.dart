import 'dart:io';

import 'package:flutter/material.dart';
import 'package:watermark_image/watermark_image.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Watermark Image'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? waterMarkedImg;
  XFile? img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: () async {
                ImagePicker picker = ImagePicker();
                img = await picker.pickImage(
                    source: ImageSource.camera, imageQuality: 10);

                waterMarkedImg = await WatermarkImage.addWaterMarkToPhoto(
                    image: File(img!.path), waterMarkText: "new waterMarkText");
                setState(() {});
              },
              child: const Text("Click image"),
            ),
            waterMarkedImg != null
                ? Image.file(waterMarkedImg!)
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
