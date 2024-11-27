import 'dart:io';

class ContainerItem {
  final String name; // 수납장 이름
  final File? image; // 이미지

  ContainerItem({required this.name, this.image});
}