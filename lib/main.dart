import 'package:flutter/material.dart';
import 'package:gallery_app/ScreenHome.dart';
import 'package:gallery_app/db/model/data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(GalleryModelAdapter().typeId)) {
    Hive.registerAdapter(GalleryModelAdapter());
  }
  await Hive.openBox<GalleryModel>('galleryDB');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CameraScreen(),
    );
  }
}
