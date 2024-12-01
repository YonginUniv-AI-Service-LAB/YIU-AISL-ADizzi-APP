class ItemModel {
  final String name;
  final String category;
  final String memo;
  final String? imagePath;

  ItemModel({
    required this.name,
    required this.category,
    required this.memo,
    this.imagePath,
  });
}
