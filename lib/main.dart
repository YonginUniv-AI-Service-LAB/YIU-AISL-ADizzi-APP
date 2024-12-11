import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/provider/tree_provider.dart';
import 'package:yiu_aisl_adizzi_app/screens/main/main_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/temp_start_screen.dart';
import 'package:yiu_aisl_adizzi_app/screens/user/login_screen.dart';
import 'package:yiu_aisl_adizzi_app/service/service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLogin;

  @override
  void initState() {
    super.initState();
    _checkAccessToken();
  }

  void _checkAccessToken() async {
    bool loginStatus = await isAccessToken();

    if (!loginStatus) {
      // 로그인 상태가 올바르지 않은 경우
      Future.delayed(Duration(seconds: 5), () {
        setState(() {
          isLogin = false; // LoginScreen으로 전환
        });
      });
    } else {
      setState(() {
        isLogin = true; // MainScreen으로 전환
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin == null) {
      return Center(child: CircularProgressIndicator()); // 데이터 로드 중 로딩 인디케이터 표시
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TreeProvider()),
      ],
      child: MaterialApp(
        title: 'ADizzi App',
        home: isLogin! ? MainScreen() : LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
