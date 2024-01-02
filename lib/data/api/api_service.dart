import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restoran_app/models/restaurant.dart';


class ApiService{
  final String apiUrl="https://restaurant-api.dicoding.dev";

  Future<List<Restaurant>> getRestourant() async{
    final response= await http.get(Uri.parse('$apiUrl/list'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body.toString());
      List<Restaurant> dataResto=[];

      for (Map<String, dynamic> row in data['restaurants']) {
        dataResto.add(Restaurant.fromJson(row));
      }

      return dataResto;
    } else {
      throw Exception('Failed to load recommendation restaurants');
    }
  }

  Future<Restaurant> getRestourantDetail(String id) async{
    final response= await http.get(Uri.parse('$apiUrl/detail/${id}'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body.toString());

      return Restaurant.fromJson(data['restaurant']);
    } else {
      throw Exception('Failed to load recommendation restaurants');
    }
  }

  Future<List<Restaurant>> getSearchRestourant(String query) async{
    final response= await http.get(Uri.parse('$apiUrl/search?q=${query}'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body.toString());

      List<Restaurant> dataResto=[];

      for (Map<String, dynamic> row in data['restaurants']) {
        dataResto.add(Restaurant.fromJson(row));
      }

      return dataResto;

    } else {
      throw Exception('Failed to load recommendation restaurants');
    }
  }

}