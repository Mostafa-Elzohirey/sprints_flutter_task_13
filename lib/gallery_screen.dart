import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();
  Future<void> pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          _images.addAll(
            images.map(
              (file) => File(file.path),
            ),
          );
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 700,
            child: ListView.builder(
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(_images[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                ElevatedButton( //opens the image picker to choose images
                  onPressed: () {
                    pickImages();
                  },
                  child: Text("Pick Images"),
                ),
                Spacer(),
                ElevatedButton( //clears the images
                  onPressed: () {
                    setState(() {
                      _images.clear();
                    });
                  },
                  child: Text("clear Images"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
