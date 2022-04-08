import 'package:bloc_state_management/cubits/favoriteRestaurantsCubit.dart';
import 'package:bloc_state_management/data/models/restaurant.dart';
import 'package:bloc_state_management/screens/favoriteScreen.dart';
import 'package:bloc_state_management/screens/widgets/restaurantContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<Restaurant> restaurants = [
  Restaurant(address: "Bhuj", id: "1", name: "Name"),
  Restaurant(address: "Bhuj", id: "2", name: "Name"),
  Restaurant(address: "Bhuj", id: "3", name: "Name"),
  Restaurant(address: "Bhuj", id: "4", name: "Name"),
  Restaurant(address: "Bhuj", id: "5", name: "Name"),
  Restaurant(address: "Bhuj", id: "6", name: "Name"),
  Restaurant(address: "Bhuj", id: "7", name: "Name"),
  Restaurant(address: "Bhuj", id: "8", name: "Name"),
  Restaurant(address: "Bhuj", id: "9", name: "Name"),
  Restaurant(address: "Bhuj", id: "10", name: "Name"),
  Restaurant(address: "Bhuj", id: "11", name: "Name"),
  Restaurant(address: "Bhuj", id: "12", name: "Name"),
  Restaurant(address: "Bhuj", id: "13", name: "Name"),
  Restaurant(address: "Bhuj", id: "14", name: "Name"),
  Restaurant(address: "Bhuj", id: "15", name: "Name"),
  Restaurant(address: "Bhuj", id: "16", name: "Name"),
  Restaurant(address: "Bhuj", id: "17", name: "Name"),
  Restaurant(address: "Bhuj", id: "18", name: "Name"),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<FavoriteRestaurantsCubit>().getFavoriteRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const FavoriteScreen()));
      }),
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return RestaurantContainer(restaurant: restaurants[index]);
          }),
    );
  }
}
