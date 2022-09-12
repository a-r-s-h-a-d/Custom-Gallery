import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class GalleryModel extends HiveObject {
  @HiveField(0)
  String imagePath;

  GalleryModel({required this.imagePath});
}
