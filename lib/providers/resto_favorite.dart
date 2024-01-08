import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restoran_app/data/database/db_helper.dart';
import 'package:restoran_app/models/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestoFavoriteProvider extends ChangeNotifier{
  late List<Restaurant> _restaurantResult;
  late ResultState _state;
  String _message = '';
  String get message => _message;
  List<Restaurant> get result => _restaurantResult;
  ResultState get state => _state;

  RestoFavoriteProvider() {
    fetchAllResto();
  }

  Future<dynamic> fetchAllResto() async{
    try {
      _state = ResultState.loading;
      notifyListeners();
      final resto = await DBHelper().get();
      if (resto.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = resto;
      }

    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }



}