import 'package:flutter/material.dart';
import 'package:yiu_aisl_adizzi_app/screens/temp/temp.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ADizzi App',
      home: TempStartScreen(),
      debugShowCheckedModeBanner: false, // 디버그 배너 비활성화
    );
  }
}
