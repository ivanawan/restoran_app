import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restoran_app/models/restaurant.dart';


class ApiService{
  final String apiUrl="https://restaurant-api.dicoding.dev";

  Future<List<Restaurant>> getRestourant() async{
    final response= await getData('list');
    if (response.statusCode == 200) {
      return parseToList(response.body.toString());
    } else {
      throw Exception('Failed to load restaurants list');
    }
  }

  Future<Restaurant> getRestourantDetail(String id) async{
    final response= await getData('detail/${id}');
    if (response.statusCode == 200) {
      var data = json.decode(response.body.toString());

      return Restaurant.fromJson(data['restaurant']);
    } else {
      throw Exception('Failed to load detail restaurants');
    }
  }

  Future<List<Restaurant>> getSearchRestourant(String query) async{
    final response= await getData('search?q=${query}');
    if (response.statusCode == 200) {
      return parseToList(response.body.toString());
    } else {
      throw Exception('Failed to load search restaurants');
    }
  }

  parseToList(String body){
    var data = json.decode(body);

    List<Restaurant> dataResto=[];

    for (Map<String, dynamic> row in data['restaurants']) {
      dataResto.add(Restaurant.fromJson(row));
    }

    return dataResto;
  }

  Future<http.Response> getData(String? query) async{
    return await http.get(Uri.parse('$apiUrl/${query}'));
  }

}

