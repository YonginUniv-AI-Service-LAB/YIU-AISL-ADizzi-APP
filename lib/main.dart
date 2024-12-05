import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yiu_aisl_adizzi_app/provider/room_provider.dart';
import 'package:yiu_aisl_adizzi_app/provider/tree_provider.dart';
import 'package:yiu_aisl_adizzi_app/screens/temp_start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoomProvider()),
        ChangeNotifierProvider(create: (_) => TreeProvider()),
      ],
      child: MaterialApp(
        title: 'ADizzi App',
        home: const TempStartScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
