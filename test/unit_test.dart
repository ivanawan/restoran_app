// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:restoran_app/data/api/api_service.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';


void main() async {
  group('API Test', () {
    test('Mock API Call', () async {
  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);
  final jsonString = '{"error": false,"message": "success","count": 20,"restaurants": [{"id": "rqdv5juczeskfw1e867","name": "Melting Pot","description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.","pictureId": "14","city": "Medan","rating": 4.2}]}';
  // Set up a mock response for GET requests to "https://example.com"
  dioAdapter.onGet(
    'https://restaurant-api.dicoding.dev/list',
        (server) => server.reply(
      200,
      jsonString,
      // Delay the response by 1 second
      delay: const Duration(seconds: 1),
    ),
  );
  final response = await dio.get('https://restaurant-api.dicoding.dev/list');
  final result = await ApiService().parseToList(response.data.toString());
      expect( result.runtimeType, List<Restaurant>);
  });
  });
}
