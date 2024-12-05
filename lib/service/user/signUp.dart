// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// Future<http.Response> signUp(String email, String password) async {
//   final String endpoint = '/signUp';
//   final String uri = '$BASE_URL$endpoint';
//
//   try {
//     final Map<String, dynamic> requestData = {
//       'email': email,
//       'password': password,
//     };
//
//     final response = await http.post(  //post 형식임 회원가입은
//       Uri.parse(uri),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(requestData),
//     );
//
//     return response;
//   } catch (e) {
//     print('예외 발생: $e');
//     throw Exception('서버와의 연결에 실패했습니다.');
//   }
// }
