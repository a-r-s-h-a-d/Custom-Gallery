// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GalleryModelAdapter extends TypeAdapter<GalleryModel> {
  @override
  final int typeId = 0;

  @override
  GalleryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GalleryModel(
      imagePath: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GalleryModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GalleryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
