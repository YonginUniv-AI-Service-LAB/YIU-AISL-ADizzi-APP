import 'dart:io';

class ContainerModel {
  final int? containerId;
  final String title; // 수납장 이름
  final int? imageId; // 이미지

  ContainerModel({this.containerId, required this.title, this.imageId, });

  factory ContainerModel.fromJson(Map<String, dynamic> json){
    return ContainerModel(
        containerId: json['containerId'],
        title: json['title'],
        imageId: json['imageId']
    );
  }
  ContainerModel changeContainer({int? containerId, required String title, int? imageId}){
    return ContainerModel(
        containerId:  containerId ?? this.containerId,
        title: title ?? this.title,
        imageId: imageId ?? this.imageId
    );
  }
}