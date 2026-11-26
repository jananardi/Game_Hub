import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'services/game_service.dart';
import 'controllers/game_controller.dart';
import 'screens/game_list_page.dart';

void main() {
  Get.put(GameService());
  Get.put(GameController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Hub',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,), useMaterial3: true,),
      home: const GameListPage(),
    );
  }
}