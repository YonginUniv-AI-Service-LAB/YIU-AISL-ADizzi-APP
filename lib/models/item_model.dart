import 'dart:io';

class ItemModel {
  final String name;
  final File image;
  final String category;
  final String memo;

  ItemModel({
    required this.name,
    required this.image,
    required this.category,
    required this.memo,
  });
}
