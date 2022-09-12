import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_app/ScreenGallery.dart';
import 'package:gallery_app/db/model/data_model.dart';
// import 'package:gallery_saver/gallery_saver.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String? imagePath;
  Box<GalleryModel>? imageBox;

  @override
  void initState() {
    imageBox = Hive.box<GalleryModel>('galleryDB');
    super.initState();
  }

  Future<void> pickImageCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    // await GallerySaver.saveImage(image.path);
    setState(() {
      imagePath = image.path;
    });
  }

  Future<void> addImageDataBase(BuildContext context) async {
    if (imagePath == null) {
      print('Path Not Found');
      return;
    }
    final _image = GalleryModel(imagePath: imagePath!);
    await imageBox!.add(_image);
    print("image added sucessfully to the database");
    addedAlertBox(context);
    setState(() {
      imagePath = null;
    });
  }

  void addedAlertBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: const Color(0xFFFDEEDC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Column(
              children: const [
                Text('Alert'),
                Divider(thickness: 2),
              ],
            ),
            content: const Text('Image added successfully to the database'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (ctx) => GalleryScreen()));
                },
                child: const Text('Ok'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Camera'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const GalleryScreen()));
            },
            icon: const Icon(Icons.photo),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: (imagePath == null)
                  ? const NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzZR-Jgeq27b8soqxgZpZPeQ6ztr1zh6q_7_3abqr06g&s')
                  : FileImage(File(imagePath!)) as ImageProvider,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: const StadiumBorder()),
              child: const Text(
                'Save to Gallery',
              ),
              onPressed: () {
                addImageDataBase(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImageCamera,
        child: Icon(Icons.photo_camera),
      ),
    );
  }
}
