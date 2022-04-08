import 'package:bloc_state_management/data/models/restaurant.dart';
import 'package:bloc_state_management/data/repositories/favoriteRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FavoriteRestaurantsState {}

class FavoriteRestaurantsInitial extends FavoriteRestaurantsState {}

class FavoriteRestaurantsFetchInProgress extends FavoriteRestaurantsState {}

class FavoriteRestaurantsFetchSuccess extends FavoriteRestaurantsState {
  final List<Restaurant> favoriteRestaurants;

  FavoriteRestaurantsFetchSuccess(this.favoriteRestaurants);
}

class FavoriteRestaurantsFetchFailure extends FavoriteRestaurantsState {
  final String errorMessage;

  FavoriteRestaurantsFetchFailure(this.errorMessage);
}

class FavoriteRestaurantsCubit extends Cubit<FavoriteRestaurantsState> {
  late FavoriteRepository favoriteRepository;
  FavoriteRestaurantsCubit() : super(FavoriteRestaurantsInitial()) {
    favoriteRepository = FavoriteRepository();
  }

  void getFavoriteRestaurants() {
    emit(FavoriteRestaurantsFetchInProgress());

    favoriteRepository.getFavoriteRestaurants().then((value) {
      emit(FavoriteRestaurantsFetchSuccess(value));
    }).catchError((e) {
      emit(FavoriteRestaurantsFetchFailure(e.toString()));
    });
  }

  void addFavoriteRestaurant(Restaurant restaurant) {
    if (state is FavoriteRestaurantsFetchSuccess) {
      final favoriteRestaurants =
          (state as FavoriteRestaurantsFetchSuccess).favoriteRestaurants;
      favoriteRestaurants.insert(0, restaurant);
      emit(FavoriteRestaurantsFetchSuccess(List.from(favoriteRestaurants)));
    }
  }

  //Can pass only restaurant id here
  void removeFavoriteRestaurant(Restaurant restaurant) {
    if (state is FavoriteRestaurantsFetchSuccess) {
      final favoriteRestaurants =
          (state as FavoriteRestaurantsFetchSuccess).favoriteRestaurants;
      favoriteRestaurants
          .removeWhere(((element) => element.id == restaurant.id));
      emit(FavoriteRestaurantsFetchSuccess(List.from(favoriteRestaurants)));
    }
  }

  bool isRestaurantFavorite(String restaurantId) {
    if (state is FavoriteRestaurantsFetchSuccess) {
      final favoriteRestaurants =
          (state as FavoriteRestaurantsFetchSuccess).favoriteRestaurants;
      return favoriteRestaurants
              .indexWhere((element) => element.id == restaurantId) !=
          -1;
    }
    return false;
  }
}
