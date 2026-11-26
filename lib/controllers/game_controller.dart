import 'package:get/get.dart';
import '../models/game_model.dart';
import '../models/game_detail_model.dart';
import '../services/game_service.dart';

class GameController extends GetxController {
  final GameService service = Get.find<GameService>();

  final games = <GameModel>[].obs;
  final favorites = <GameModel>[].obs;

  final isLoading = false.obs;
  final isDetailLoading = false.obs;
  final errorMessage = ''.obs;
  final searchQuery = ''.obs;

  final selectedCategory = 'all'.obs;
  final selectedPlatform = 'all'.obs;
  final selectedSort = 'none'.obs;

  final gameDetail = Rxn<GameDetailModel>();

  @override
  void onInit() {
    super.onInit();
    fetchGames();
  }

  Future<void> fetchGames() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await service.getGames(
        category: selectedCategory.value,
        platform: selectedPlatform.value,
        sortBy: selectedSort.value,
      );

      if (response.statusCode == 200 && response.body is List) {
        games.assignAll(
          (response.body as List).map(
                (json) => GameModel.fromJson(json),),
        );
      } else {
        errorMessage.value = 'Não foi possível carregar os jogos.';
      }
    } catch (e) {
      errorMessage.value = 'Erro de conexão. Tente novamente.';
    } finally {
      isLoading.value = false;
    }
  }

  List<GameModel> get filteredGames {
    if (searchQuery.value.isEmpty) {
      return games;
    }

    return games.where((game) {
      return game.title
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase());
    }).toList();
  }

  Future<void> fetchGameDetails(int id) async {
    try {
      isDetailLoading.value = true;
      gameDetail.value = null;

      final response = await service.getGameDetails(id);

      if (response.statusCode == 200 && response.body is Map) {
        gameDetail.value = GameDetailModel.fromJson(
          Map<String, dynamic>.from(response.body),
        );
      } else {
        Get.snackbar('Erro', 'Não foi possível carregar os detalhes.');
      }
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao buscar os detalhes do jogo.');
    } finally {
      isDetailLoading.value = false;
    }
  }

  void toggleFavorite(GameModel game) {
    final exists = favorites.any((item) => item.id == game.id);

    if (exists) {
      favorites.removeWhere((item) => item.id == game.id);
      Get.snackbar('Favoritos', 'Jogo removido dos favoritos.');
    } else {
      favorites.add(game);
      Get.snackbar('Favoritos', 'Jogo adicionado aos favoritos.');
    }
  }

  bool isFavorite(int id) {
    return favorites.any((game) => game.id == id);
  }

  void removeFavorite(int id) {
    favorites.removeWhere((game) => game.id == id);
  }

  void clearFilters() {
    selectedCategory.value = 'all';
    selectedPlatform.value = 'all';
    selectedSort.value = 'none';
    searchQuery.value = '';

    fetchGames();
  }
}