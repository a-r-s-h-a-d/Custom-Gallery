import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_app/db/model/data_model.dart';

class ViewPhoto extends StatelessWidget {
  const ViewPhoto({
    super.key,
    required this.imageModel,
  });
  final GalleryModel imageModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Image'),
      ),
      body: Center(
        child: Image(
          image: FileImage(
            File(imageModel.imagePath),
          ),
        ),
      ),
    );
  }
}
