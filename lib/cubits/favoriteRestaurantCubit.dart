import 'package:bloc_state_management/data/models/restaurant.dart';
import 'package:bloc_state_management/data/repositories/favoriteRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UpdateRestaurantFavoriteStatusState {}

class UpdateRestaurantFavoriteStatusInitial
    extends UpdateRestaurantFavoriteStatusState {}

class UpdateRestaurantFavoriteStatusInProgress
    extends UpdateRestaurantFavoriteStatusState {}

class UpdateRestaurantFavoriteStatusSuccess
    extends UpdateRestaurantFavoriteStatusState {
  final Restaurant restaurant;
  final bool
      wasFavoriteRestaurantProcess; //to check that process is to favorite the restaurant or not
  UpdateRestaurantFavoriteStatusSuccess(
      this.restaurant, this.wasFavoriteRestaurantProcess);
}

class UpdateRestaurantFavoriteStatusFailure
    extends UpdateRestaurantFavoriteStatusState {
  final String errorMessage;

  UpdateRestaurantFavoriteStatusFailure(this.errorMessage);
}

class UpdateRestaurantFavoriteStatusCubit
    extends Cubit<UpdateRestaurantFavoriteStatusState> {
  late FavoriteRepository favoriteRepository;
  UpdateRestaurantFavoriteStatusCubit()
      : super(UpdateRestaurantFavoriteStatusInitial()) {
    favoriteRepository = FavoriteRepository();
  }

  void favoriteRestaurant(
      {required String userId, required Restaurant restaurant}) {
    //
    emit(UpdateRestaurantFavoriteStatusInProgress());
    favoriteRepository
        .favoriteRestaurant(userId: userId, restaurantId: restaurant.id)
        .then((value) {
      emit(UpdateRestaurantFavoriteStatusSuccess(restaurant, true));
    }).catchError((e) {
      emit(UpdateRestaurantFavoriteStatusFailure(e.toString()));
    });
  }

  //can pass only restaurant id here
  void unFavoriteRestaurant(
      {required String userId, required Restaurant restaurant}) {
    emit(UpdateRestaurantFavoriteStatusInProgress());
    favoriteRepository
        .unFavoriteRestaurant(userId: userId, restaurantId: restaurant.id)
        .then((value) {
      emit(UpdateRestaurantFavoriteStatusSuccess(restaurant, false));
    }).catchError((e) {
      emit(UpdateRestaurantFavoriteStatusFailure(e.toString()));
    });
  }
}
