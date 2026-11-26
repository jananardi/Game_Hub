class GameDetailModel {
  final int id;
  final String title;
  final String thumbnail;
  final String description;
  final String genre;
  final String platform;
  final String developer;
  final String publisher;
  final String releaseDate;
  final String gameUrl;
  final String minimumSystemRequirements;

  GameDetailModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.description,
    required this.genre,
    required this.platform,
    required this.developer,
    required this.publisher,
    required this.releaseDate,
    required this.gameUrl,
    required this.minimumSystemRequirements,
  });

  factory GameDetailModel.fromJson(Map<String, dynamic> json) {
    final requirements = json['minimum_system_requirements'];

    return GameDetailModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Sem título',
      thumbnail: json['thumbnail'] ?? '',
      description: json['description'] ?? 'Descrição não disponível.',
      genre: json['genre'] ?? 'Não informado',
      platform: json['platform'] ?? 'Não informado',
      developer: json['developer'] ?? 'Não informado',
      publisher: json['publisher'] ?? 'Não informado',
      releaseDate: json['release_date'] ?? 'Não informado',
      gameUrl: json['game_url'] ?? '',
      minimumSystemRequirements: requirements is Map
          ? requirements.entries
          .map((e) => '${e.key}: ${e.value}')
          .join('\n')
          : 'Requisitos não disponíveis.',
    );
  }
}