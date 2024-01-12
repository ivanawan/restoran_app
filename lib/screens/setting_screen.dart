import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/providers/scheduling_provider.dart';
import 'package:restoran_app/screens/search_screen.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SearchScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.search, size: 30, weight: 500))
                  ],
                ),
                const SizedBox(
                  height: 100,
                  child: ListTile(
                    title: Text(
                      'Setting',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Allow Notification'),
                    Consumer<SchedulingProvider>(
                        builder: (context, scheduled, _) {
                          scheduled.getSetting();
                      return Switch(
                        value: scheduled.isScheduled,
                        onChanged: (val) {
                         scheduled.scheduledNotification(val);
                        },
                      );
                    }
                    ),
                  ],
                ),
              ],
            )
        )
    );
  }

}
