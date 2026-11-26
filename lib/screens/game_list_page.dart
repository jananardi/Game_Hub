import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/game_controller.dart';
import '../components/game_card.dart';
import 'game_detail_page.dart';
import 'favorite_page.dart';

class GameListPage extends StatelessWidget {
  const GameListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GameController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Hub', style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {Get.to(() => const FavoritePage());},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {controller.searchQuery.value = value;},
              decoration: const InputDecoration(
                hintText: 'Buscar jogo pelo nome...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => DropdownButtonFormField<String>(
                        value: controller.selectedPlatform.value,
                        decoration: const InputDecoration(
                          labelText: 'Plataforma',
                          border: OutlineInputBorder(),),
                        items: const [
                          DropdownMenuItem(
                            value: 'all',
                            child: Text('Todas'),
                          ),
                          DropdownMenuItem(
                            value: 'windows',
                            child: Text('Windows'),
                          ),
                          DropdownMenuItem(
                            value: 'browser',
                            child: Text('Navegador'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedPlatform.value = value;
                            controller.fetchGames();}
                        },
                      )),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Obx(() => DropdownButtonFormField<String>(
                        value: controller.selectedCategory.value,
                        decoration: const InputDecoration(
                          labelText: 'Categoria',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'all',
                            child: Text('Todas'),
                          ),
                          DropdownMenuItem(
                            value: 'shooter',
                            child: Text('Shooter'),
                          ),
                          DropdownMenuItem(
                            value: 'mmorpg',
                            child: Text('MMORPG'),
                          ),
                          DropdownMenuItem(
                            value: 'strategy',
                            child: Text('Strategy'),
                          ),
                          DropdownMenuItem(
                            value: 'racing',
                            child: Text('Racing'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedCategory.value = value;
                            controller.fetchGames();
                          }
                        },
                      )),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Obx(() => DropdownButtonFormField<String>(
                        value: controller.selectedSort.value,
                        decoration: const InputDecoration(
                          labelText: 'Ordenação',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'none',
                            child: Text('Padrão'),
                          ),
                          DropdownMenuItem(
                            value: 'popularity',
                            child: Text('Popularidade'),
                          ),
                          DropdownMenuItem(
                            value: 'alphabetical',
                            child: Text('Alfabética'),
                          ),
                          DropdownMenuItem(
                            value: 'release-date',
                            child: Text('Lançamento'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            controller.selectedSort.value = value;
                            controller.fetchGames();
                          }
                        },
                      )),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: controller.clearFilters,
                      child: const Text('Limpar filtros'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (controller.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.errorMessage.value),
                      ElevatedButton(
                        onPressed: controller.fetchGames,
                        child: const Text('Tentar novamente'),
                      ),
                    ],
                  ),
                );
              }
              final games = controller.filteredGames;
              if (games.isEmpty) {
                return const Center(
                  child: Text('Nenhum jogo encontrado.'),
                );
              }
              return RefreshIndicator(
                onRefresh: controller.fetchGames,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final screenWidth = constraints.maxWidth;
                    final crossAxisCount = screenWidth >= 1000
                        ? 3
                        : screenWidth >= 600
                        ? 2
                        : 1;
                    return GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 340,
                        mainAxisExtent: 290,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: games.length,
                      itemBuilder: (context, index) {
                        final game = games[index];
                        return GameCard(
                          game: game,
                          onTap: () {
                            Get.to(
                                  () => GameDetailPage(game: game),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}