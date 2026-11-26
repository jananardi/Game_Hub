import 'package:flutter/material.dart';
import '../models/game_model.dart';

class GameCard extends StatelessWidget {
  final GameModel game;
  final VoidCallback onTap;
  final double imageHeight;

  const GameCard({
    super.key,
    required this.game,
    required this.onTap,
    this.imageHeight = 170,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: imageHeight,
              child: Image.network(
                game.thumbnail,
                key: ValueKey('image-${game.id}'),
                fit: BoxFit.cover,
                webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.image_not_supported),);},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,),),
                  const SizedBox(height: 6),
                  Text('Gênero: ${game.genre}'),
                  Text('Plataforma: ${game.platform}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
