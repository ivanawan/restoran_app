import 'package:cron/cron.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:restoran_app/data/preference/setting.dart';
import 'package:restoran_app/utils/background_service.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;

  getSetting() async {
    _isScheduled= await SettingService().getSetting('notification');
    notifyListeners();
  }


  scheduledNotification(bool value) async {
    _isScheduled = value;
    final cron = Cron();
    final DateTime now = DateTime.now();
    SettingService().updateSetting('notification', value);
    try {
      if (_isScheduled) {
        notifyListeners();

        cron.schedule(Schedule.parse('0 11 * * * '), ()async{
          BackgroundService().callback();
         Logger().i("[$now] Hello, world!");
        });

        // await Future.delayed(Duration(seconds: 20));
      } else {
        await cron.close();
        Logger().i('Scheduling Notification Canceled');
        notifyListeners();
      }
    } on ScheduleParseException {
      // "ScheduleParseException" is thrown if cron parsing is failed.
      await cron.close();
    }
  }

}
