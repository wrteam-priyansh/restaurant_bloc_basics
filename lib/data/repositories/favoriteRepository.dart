import 'package:bloc_state_management/data/models/restaurant.dart';

class FavoriteRepository {
  Future<List<Restaurant>> getFavoriteRestaurants() async {
    await Future.delayed(const Duration(seconds: 2));
    return [];
  }

  Future<bool> favoriteRestaurant(
      {required String userId, required String restaurantId}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  Future<bool> unFavoriteRestaurant(
      {required String userId, required String restaurantId}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }
}
