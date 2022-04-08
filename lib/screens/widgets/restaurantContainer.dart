import 'package:bloc_state_management/cubits/favoriteRestaurantCubit.dart';
import 'package:bloc_state_management/cubits/favoriteRestaurantsCubit.dart';
import 'package:bloc_state_management/data/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantContainer extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantContainer({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpdateRestaurantFavoriteStatusCubit>(
      create: (context) => UpdateRestaurantFavoriteStatusCubit(),
      child: Builder(builder: (context) {
        return ListTile(
          trailing: BlocBuilder<FavoriteRestaurantsCubit,
                  FavoriteRestaurantsState>(
              bloc: context.read<FavoriteRestaurantsCubit>(),
              builder: (context, favoriteRestaurantState) {
                if (favoriteRestaurantState
                    is FavoriteRestaurantsFetchSuccess) {
                  //check if restaurant is favorite or not
                  bool isRestaurantFavorite = context
                      .read<FavoriteRestaurantsCubit>()
                      .isRestaurantFavorite(restaurant.id);
                  return BlocConsumer<UpdateRestaurantFavoriteStatusCubit,
                      UpdateRestaurantFavoriteStatusState>(
                    bloc: context.read<UpdateRestaurantFavoriteStatusCubit>(),
                    listener: ((context, state) {
                      //
                      if (state is UpdateRestaurantFavoriteStatusSuccess) {
                        //
                        if (state.wasFavoriteRestaurantProcess) {
                          context
                              .read<FavoriteRestaurantsCubit>()
                              .addFavoriteRestaurant(state.restaurant);
                        } else {
                          //
                          context
                              .read<FavoriteRestaurantsCubit>()
                              .removeFavoriteRestaurant(state.restaurant);
                        }
                      }
                    }),
                    builder: (context, state) {
                      if (state is UpdateRestaurantFavoriteStatusInProgress) {
                        return Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            height: 15,
                            width: 15,
                            child: const CircularProgressIndicator());
                      }
                      return IconButton(
                          onPressed: () {
                            //
                            if (state
                                is UpdateRestaurantFavoriteStatusInProgress) {
                              return;
                            }
                            if (isRestaurantFavorite) {
                              context
                                  .read<UpdateRestaurantFavoriteStatusCubit>()
                                  .unFavoriteRestaurant(
                                      userId: "userId", restaurant: restaurant);
                            } else {
                              //
                              context
                                  .read<UpdateRestaurantFavoriteStatusCubit>()
                                  .favoriteRestaurant(
                                      userId: "userId", restaurant: restaurant);
                            }
                          },
                          icon: isRestaurantFavorite
                              ? const Icon(Icons.favorite)
                              : const Icon(Icons.favorite_border));
                    },
                  );
                }
                //if some how failed to fetch favorite restaurants or still fetching the restaurants
                return const SizedBox();
              }),
          title: Text(restaurant.name),
          leading: CircleAvatar(
            child: Text(restaurant.id),
          ),
        );
      }),
    );
  }
}
