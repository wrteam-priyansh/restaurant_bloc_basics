import 'package:bloc_state_management/cubits/favoriteRestaurantsCubit.dart';
import 'package:bloc_state_management/screens/widgets/restaurantContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<FavoriteRestaurantsCubit, FavoriteRestaurantsState>(
        builder: (context, state) {
          if (state is FavoriteRestaurantsFetchInProgress ||
              state is FavoriteRestaurantsInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FavoriteRestaurantsFetchFailure) {
            return const SizedBox();
          }
          final favoriteRestaurants =
              (state as FavoriteRestaurantsFetchSuccess).favoriteRestaurants;
          return ListView.builder(
              itemCount: favoriteRestaurants.length,
              itemBuilder: (context, index) {
                return RestaurantContainer(
                    restaurant: favoriteRestaurants[index]);
              });
        },
      ),
    );
  }
}
