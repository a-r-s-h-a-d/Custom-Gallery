import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_app/db/model/data_model.dart';
import 'package:gallery_app/photo_viewer.dart';

import 'package:hive_flutter/hive_flutter.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  Box<GalleryModel>? imageBox;

  @override
  void initState() {
    imageBox = Hive.box<GalleryModel>('galleryDB');
    super.initState();
  }

  void deletedAlertBox(int key) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Column(
              children: const [
                Text('Alert'),
                Divider(thickness: 2),
              ],
            ),
            content: Text('Do you want to confirm the deletion'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await imageBox!.delete(key);
                  Navigator.pop(ctx);
                },
                child: Text('Ok'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gallery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ValueListenableBuilder(
          valueListenable: imageBox!.listenable(),
          builder:
              (BuildContext context, Box<GalleryModel> images, Widget? child) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15),
              itemCount: images.length,
              itemBuilder: (context, index) {
                final key = images.keys.toList()[index];
                final _image = images.get(key);
                return GestureDetector(
                  onLongPress: () {
                    deletedAlertBox(key);
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => ViewPhoto(
                          imageModel: _image!,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    child: Image(
                      fit: BoxFit.cover,
                      image: FileImage(
                        File(_image!.imagePath),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
