import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:restoran_app/data/api/api_service.dart';
import 'package:restoran_app/models/restaurant.dart';

enum ResultState { loading, noData, hasData, error }
class DetailRestoProvider extends ChangeNotifier{
  late String id;
  late Restaurant _restaurantResult;
  late ResultState _state;
  String _message = '';
  String get message => _message;
  Restaurant get result => _restaurantResult;
  ResultState get state => _state;

  DetailRestoProvider({required this.id}){
    _fetchDetailResto(id);
  }

  Future<dynamic> _fetchDetailResto(String id) async{
    try {
      _state = ResultState.loading;
      notifyListeners();
      final resto = await ApiService().getRestourantDetail(id);
      Logger().i(resto);
      // if (resto.isEmpty) {
      //   _state = ResultState.noData;
      //   notifyListeners();
      //   return _message = 'Empty Data';
      // } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = resto;
      // }
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