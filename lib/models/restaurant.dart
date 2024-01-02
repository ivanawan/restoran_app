import 'dart:convert';

import 'package:restoran_app/models/category.dart';
import 'package:restoran_app/models/menu.dart';
import 'package:restoran_app/models/review.dart';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late num rating;
  late String? address;
  late List<Category>? categories;
  late Menus? menu;
  late List<Review>? reviews;

  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      });

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    address = restaurant['address'];
    categories = restaurant['categories'] != null
        ? List<Category>.from(
      (restaurant['categories'] as List)
          .map((e) => Category.fromJson(e)),
    )
        : null;
    rating = restaurant['rating'];
    menu = restaurant['menus'] != null
        ?  Menus.fromJson(restaurant["menus"])
        : null;
    reviews = restaurant['customerReviews'] != null
        ? List<Review>.from(restaurant["customerReviews"].map((x) => Review.fromJson(x)))
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "pictureId": pictureId,
      "city": city,
      "rating": rating,
    };
  }
}

