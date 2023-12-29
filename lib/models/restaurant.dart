import 'dart:convert';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late num rating;
  late List<dynamic> drinks;
  late List<dynamic> food;

  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.drinks,
      required this.food});

  factory Restaurant.fromJson(Map<String, dynamic> resto) => Restaurant(
        id: resto['id'],
        name: resto['name'],
        description: resto['description'],
        pictureId: resto['pictureId'],
        city: resto['city'],
        rating: resto['rating'],
        drinks: resto['menus']['drinks'],
        food: resto['menus']['foods'],
      );
}

List<Restaurant> parseRestaurant(String? json) {
  List<Restaurant> dataResto = [];
  if (json == null) {
    return dataResto;
  }
  var parsed = jsonDecode(json);

  for (Map<String, dynamic> row in parsed['restaurants']) {
    dataResto.add(Restaurant.fromJson(row));
  }

  return dataResto;
}
