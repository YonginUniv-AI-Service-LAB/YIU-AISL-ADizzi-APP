import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

// 토큰 저장
Future<void> saveToken(String token) async{
  await storage.write(key: 'user_token', value: token);
}

// 토큰 불러오기
Future<String?> getToken() async{
  return await storage.read(key : 'user_token');
}