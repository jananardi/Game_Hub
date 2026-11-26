import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/game_controller.dart';
import '../components/game_card.dart';
import 'game_detail_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GameController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus favoritos'),
      ),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return const Center(
            child: Text('Você ainda não possui favoritos.'),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final game = controller.favorites[index];
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 380,),
                child: Column(
                  children: [
                    GameCard(
                      key: ValueKey(game.id), game: game, imageHeight: 140,
                      onTap: () {
                        Get.to(() => GameDetailPage(game: game),);},
                    ),
                    TextButton.icon(
                      onPressed: () {controller.removeFavorite(game.id);},
                      icon: const Icon(Icons.delete),
                      label: const Text('Remover dos favoritos'),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
