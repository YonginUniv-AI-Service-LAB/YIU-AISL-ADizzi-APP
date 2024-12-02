class ItemModel {
  final String title;
  final String category;
  final String detail;
  final String? imagePath;
  bool isChecked;

  ItemModel({
    required this.title,
    required this.category,
    required this.detail,
    this.imagePath,
    this.isChecked = false,
  });
}
