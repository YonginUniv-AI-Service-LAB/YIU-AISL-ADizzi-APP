import 'dart:convert';

// Room 데이터 모델
class RoomModel {
  final int roomId;
  final String? title;
  final int? icon;
  final int? color;
  final DateTime? updatedAt;
  final List<ContainerModel> containers;

  RoomModel({
    required this.roomId,
    this.title,
    this.icon,
    this.color,
    this.updatedAt,
    List<ContainerModel>? containers, // nullable 리스트로 변경
  }) : containers = containers ?? []; // 기본값을 빈 리스트로 설정

  // JSON 데이터를 Room 객체로 변환
  factory RoomModel.fromJson(Map<String, dynamic> json) {
    var list = json['containers'] as List?; // null 체크 추가
    List<ContainerModel> containerList = list != null
        ? list.map((i) => ContainerModel.fromJson(i)).toList()
        : [];
    return RoomModel(
      roomId: json['roomId'],
      title: json['title'],
      icon: json['icon'],
      color: json['color'],
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      containers: containerList,
    );
  }
}

// Container 데이터 모델
class ContainerModel {
  final int containerId;
  final String? title;
  final int? slotId;
  final String? imageUrl;
  final DateTime? updatedAt;
  final List<SlotModel> slots;

  ContainerModel({
    required this.containerId,
    this.title,
    this.slotId,
    this.updatedAt,
    this.imageUrl,
    List<SlotModel>? slots, // nullable 리스트로 변경
  }) : slots = slots ?? []; // 기본값을 빈 리스트로 설정

  // JSON 데이터를 Container 객체로 변환
  factory ContainerModel.fromJson(Map<String, dynamic> json) {
    var list = json['slots'] as List?; // null 체크 추가
    List<SlotModel> slotsList = list != null
        ? list.map((i) => SlotModel.fromJson(i)).toList()
        : [];
    return ContainerModel(
      containerId: json['containerId'],
      title: json['title'],
      slotId: json['slotId'],
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      imageUrl: json['imageUrl'],
      slots: slotsList
    );
  }
}

// Slot 데이터 모델
class SlotModel {
  final int slotId;
  final String? title;
  final String? imageUrl;
  final DateTime? updatedAt;

  SlotModel({
    required this.slotId,
    this.title,
    this.updatedAt,
    this.imageUrl,
  });

  // JSON 데이터를 Slot 객체로 변환
  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      slotId: json['slotId'],
      title: json['title'],
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      imageUrl: json['imageUrl'],
    );
  }
}

// Item 데이터 모델
class ItemModel {
  final int itemId;
  final String? title;
  final String? detail;
  final String? mainCategory; // 대분류
  final String? subCategory; // 소분류
  final int? category;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  /// 여기에 있으면 안된다고 생각하는 변수지만 일단 남겨둠
  bool isChecked;

  ItemModel({
    required this.itemId,
    this.title,
    this.detail,
    this.mainCategory,
    this.subCategory,
    this.category,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.isChecked = false,
  });

  // JSON 데이터를 Item 객체로 변환
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      itemId: json['itemId'],
      title: json['title'],
      detail: json['detail'],
      mainCategory: json['mainCategory'],
      subCategory: json['subCategory'],
      category: json['category'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      imageUrl: json['imageUrl'],
    );
  }
}