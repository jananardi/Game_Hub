import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/game_controller.dart';
import '../models/game_model.dart';
import 'package:url_launcher/url_launcher.dart';

class GameDetailPage extends StatefulWidget {
  final GameModel game;

  const GameDetailPage({
    super.key,
    required this.game,
  });

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  final controller = Get.find<GameController>();

  @override
  void initState() {
    super.initState();
    controller.fetchGameDetails(widget.game.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do jogo'),
      ),
      body: Obx(() {
        if (controller.isDetailLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),);
        }
        final detail = controller.gameDetail.value;
        if (detail == null || detail.id != widget.game.id) {
          return const Center(
            child: Text('Não foi possível carregar o jogo.'),);}
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                detail.thumbnail,
                width: double.infinity,
                height: 190,
                fit: BoxFit.contain,
                webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 190,
                    child: Center(
                      child: Icon(Icons.image_not_supported),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Text(
                detail.title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Sobre o jogo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(detail.description),
              const SizedBox(height: 20),
              Text('Gênero: ${detail.genre}'),
              Text('Plataforma: ${detail.platform}'),
              Text('Desenvolvedora: ${detail.developer}'),
              Text('Publicadora: ${detail.publisher}'),
              Text('Data de lançamento: ${detail.releaseDate}'),
              const SizedBox(height: 20),
              const Text(
                'Requisitos mínimos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(detail.minimumSystemRequirements),
              const SizedBox(height: 20),
              if (detail.gameUrl.isNotEmpty)
                ElevatedButton.icon(
                  onPressed: () async {
                    final uri = Uri.parse(detail.gameUrl);

                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      Get.snackbar('Erro', 'Não foi possível abrir o jogo.');
                    }
                  },
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Acessar jogo'),
                ),
              const SizedBox(height: 12),
              Obx(() {
                final isFavorite =
                controller.isFavorite(widget.game.id);
                return ElevatedButton.icon(
                  onPressed: () {controller.toggleFavorite(widget.game);},
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  label: Text(
                    isFavorite
                        ? 'Remover dos favoritos'
                        : 'Adicionar aos favoritos',
                  ),
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}