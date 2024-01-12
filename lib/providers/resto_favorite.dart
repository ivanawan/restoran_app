
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:restoran_app/data/api/api_service.dart';
import 'package:restoran_app/data/database/db_helper.dart';
import 'package:restoran_app/models/restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestoFavoriteProvider extends ChangeNotifier{
  late List<Restaurant> _restaurantResult;
  late ResultState _state;
  String _message = '';
  bool _favorite =false;
  bool get favorite => _favorite;
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

  Future<void> unFavorite(String id) async {
    try {
      await DBHelper().delete(id);
      await fetchAllResto();
      _favorite=false;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
    }

  }

  Future<void> favorited(String id) async {
    try {
      if(!favorite){
        Restaurant data = await ApiService().getRestourantDetail(id);
        await DBHelper().insert(data);
      }

      await fetchAllResto();
      _favorite=true;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
    }
  }

  Future<void> checkFavorit(String id) async {
    List<Restaurant> result=await DBHelper().getById(id);
     _favorite=result.isNotEmpty;
    notifyListeners();
  }


}