// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:restoran_app/data/api/api_service.dart';
import 'package:restoran_app/models/restaurant.dart';


void main() {
  test('testing api get restaurant list ', ()  async {
    var data_list = await ApiService().getRestourant();

    expect( data_list.runtimeType, List<Restaurant>);
  });

  test('testing api get restaurant detail ', ()  async {
    var id='rqdv5juczeskfw1e867';
    var data_list = await ApiService().getRestourantDetail(id);

    expect( data_list.runtimeType, Restaurant);
  });
}
