
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'package:logger/logger.dart';
import 'package:restoran_app/main.dart';
import 'package:restoran_app/data/api/api_service.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:restoran_app/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService{
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  Future<void> callback() async {
    Logger().i('alarm Fired');
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService().getRestourant();
    final lenth= result.length;
    int index= Random().nextInt(lenth);
    Logger().i(result.elementAt(index));
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin,
        result.elementAt(index)
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  int getRandomIndex(List<Restaurant> restaurantList){
   final lenth= restaurantList.length;
   return Random().nextInt(lenth+1);
  }
}