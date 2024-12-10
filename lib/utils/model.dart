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
  final int? slotId;
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
    this.slotId,
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
      slotId: json['slotId'],
      category: json['category'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      imageUrl: json['imageUrl'],
    );
  }
}

class SlotsResponse {
  final List<SlotModel> slots;
  final List<ItemModel> items;

  SlotsResponse({required this.slots, required this.items});

  factory SlotsResponse.fromJson(Map<String, dynamic> json) {
    return SlotsResponse(
      slots: (json['slots'] as List)
          .map((slot) => SlotModel.fromJson(slot))
          .toList(),
      items: (json['items'] as List)
          .map((item) => ItemModel.fromJson(item))
          .toList(),
    );
  }
}

String getCategoryName(int? category) {
  if (category == null) {return "카테고리 없음";}
  // 카테고리 매핑
  const Map<int, String> categoryMap = {
    1001: "아우터",
    1002: "상의",
    1003: "하의",
    1004: "속옷",
    1005: "신발",
    2006: "가방",
    2007: "지갑",
    2008: "주얼리",
    2009: "시계",
    2010: "안경/선글라스",
    2011: "벨트",
    2012: "모자",
    2013: "목도리",
    2014: "헤어액세서리",
    2015: "우산",
    2016: "장갑",
    2017: "양말",
    2018: "운동복",
    2019: "수영복",
    3020: "스킨케어",
    3021: "바디케어",
    3022: "헤어케어",
    3023: "향수",
    3024: "클렌징",
    3025: "메이크업",
    3026: "네일",
    3027: "여성용품",
    3028: "메이크업소품",
    4029: "분유/이유식",
    4030: "기저귀",
    4031: "의류",
    4032: "장난감/완구",
    4033: "생활용품",
    5034: "간식",
    5035: "사료",
    5036: "의류",
    5037: "용품",
    6038: "주방용품",
    6039: "생활용품",
    6040: "욕실용품",
    6041: "수납/정리용품",
    6042: "청소용품",
    6043: "위생용품",
    6044: "보안용품",
    6045: "세탁용품",
    7046: "대형가전",
    7047: "주방가전",
    7048: "미용가전",
    7049: "욕실가전",
    7050: "생활가전",
    8051: "휴대폰",
    8052: "웨어러블 디바이스",
    8053: "태블릿PC",
    8054: "음향기기",
    8055: "게이밍",
    8056: "카메라",
    8057: "액세서리",
    9058: "노트북",
    9059: "데스크탑",
    9060: "모니터",
    9061: "프린터",
    9062: "키보드/마우스",
    9063: "주변기기",
    9064: "소프트웨어",
    10000: "도서",
    11000: "취미",
    12000: "문구",
    13000: "악기",
    14000: "스포츠/레저",
    15000: "건강/의료용품",
    16000: "차량용품",
    17000: "공구",
    18000: "기념품",
    19000: "서류",
    20000: "식품",
  };

  // 카테고리 이름 반환
  return categoryMap[category] ?? "카테고리 없음";
}

