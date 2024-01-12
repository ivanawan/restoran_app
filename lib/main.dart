import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/data/preference/setting.dart';
import 'package:restoran_app/providers/resto_favorite.dart';
import 'package:restoran_app/providers/scheduling_provider.dart';
import 'package:restoran_app/providers/search_resto_provider.dart';
import 'package:restoran_app/screens/detail.dart';
import 'package:restoran_app/screens/initial_screen.dart';
import 'package:restoran_app/utils/background_service.dart';
import 'package:restoran_app/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => RestoFavoriteProvider()),
      ChangeNotifierProvider(create: (_) => SchedulingProvider()),
      ChangeNotifierProvider(create: (_) => SearchRestoProvider()),
    ],child: MaterialApp(
      title: 'Flutter Resto APP',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute:'/',
      navigatorKey: navigatorKey,
      routes: {
        '/':(context)=> initialScreen(),
        '/detail':(context)=>Detail(
            id:ModalRoute.of(context)?.settings.arguments as String,
        )
      },
      // home: Text('fff'),
    )
    );
  }
}

