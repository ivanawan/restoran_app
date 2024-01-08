import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restoran_app/data/api/api_service.dart';
import 'package:restoran_app/models/restaurant.dart';

enum ResultState { loading, noData, hasData, error }
class SearchRestoProvider extends ChangeNotifier{
  late String? query;
  late List<Restaurant> _restaurantResult;
  late ResultState _state;
  String _message = '';
  String get message => _message;
  List<Restaurant> get result => _restaurantResult;
  ResultState get state => _state;

  SearchRestoProvider({ this.query}){
    fetchSearchResto(query??'');
  }

  Future<dynamic> fetchSearchResto(String query) async{
    try {
      _state = ResultState.loading;
      notifyListeners();
      final resto = await ApiService().getSearchRestourant(query);
      if (resto.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = resto;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message =
      'No Internet connection. please check your Internet Connection and try Again';

    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}