import 'package:get/get.dart';

class GameService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://www.freetogame.com/api';
    httpClient.timeout = const Duration(seconds: 20);
    httpClient.defaultContentType = 'text/plain';
    super.onInit();
  }

  Future<Response> getGames({
    String? category,
    String? platform,
    String? sortBy,
  }) async {
    final parameters = <String, String>{};

    if (category != null && category != 'all') {
      parameters['category'] = category;
    }

    if (platform != null && platform != 'all') {
      parameters['platform'] = platform;
    }

    if (sortBy != null && sortBy != 'none') {
      parameters['sort-by'] = sortBy;
    }

    final response = await get('/games', query: parameters);

    return response;
  }

  Future<Response> getGameDetails(int id) async {
    return await get('/game', query: {'id': id.toString()});
  }
}