import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/providers/resto_provider.dart';
import 'package:restoran_app/screens/search_screen.dart';
import 'package:restoran_app/utils/notification_helper.dart';
import 'package:restoran_app/widgets/resto_llist.dart';

class MyHomePage extends StatefulWidget {
  // const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();


  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(),
                        ),
                      );
                    }, icon: const Icon(Icons.search,size: 30,weight:500))
                  ],),
                const SizedBox(
                    height: 100,
                  child: ListTile(
                      title: Text(
                        'Restaurant',
                        style: TextStyle(fontSize: 30),
                      ),
                      subtitle: Text('Recommendation Restaurant For You')),
                ),
                ChangeNotifierProvider<RestoProvider>(
                  create:(_)=> RestoProvider(),
                  child:  RestoList(),
                )
              ],
            )
        )
    );
  }
}
