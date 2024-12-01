class RoomModel {
  late final int? roomId;  // null을 허용하는 roomId
  final String title;

  RoomModel({this.roomId, required this.title});

  // fromJson 메서드
  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      roomId: json['roomId'],  // 서버에서 받은 roomId
      title: json['title'],  // 서버에서 받은 title
    );
  }

  RoomModel changeRoom({int? roomId, required String title}){
    return RoomModel(
      roomId: roomId ?? this.roomId,
      title: title ?? this.title,
    );
  }
}

