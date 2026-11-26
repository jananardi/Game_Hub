class GameModel {
  final int id;
  final String title;
  final String thumbnail;
  final String genre;
  final String platform;
  final String shortDescription;
  final String gameUrl;
  final String releaseDate;

  GameModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.genre,
    required this.platform,
    required this.shortDescription,
    required this.gameUrl,
    required this.releaseDate,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Sem título',
      thumbnail: json['thumbnail'] ?? '',
      genre: json['genre'] ?? 'Não informado',
      platform: json['platform'] ?? 'Não informado',
      shortDescription: json['short_description'] ?? '',
      gameUrl: json['game_url'] ?? '',
      releaseDate: json['release_date'] ?? '',
    );
  }
}