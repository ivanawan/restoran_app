import 'package:flutter/material.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:restoran_app/screens/detail.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                const Spacer(),
                const Expanded(
                  flex: 1,
                  child: ListTile(
                      title: Text(
                        'Restaurant',
                        style: TextStyle(fontSize: 30),
                      ),
                      subtitle: Text('Recommendation Restaurant For You')),
                ),
                Expanded(
                  flex: 8,
                  child: FutureBuilder<String>(
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/local_restaurant.json'),
                    builder: (context, snapshot) {
                      final List<Restaurant> restaurant =
                          parseRestaurant(snapshot.data);
                      return ListView.builder(
                        itemCount: restaurant.length,
                        itemBuilder: (context, index) {
                          return _buildRestaurantItem(
                              context, restaurant[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            )));
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return GestureDetector(
        onTap: () {
          // Navigator.push(context, Detail(restaurant: restaurant));
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Detail(restaurant: restaurant),
            ),
          );
        },
        child: Card(
          child: Row(children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.network(
                    restaurant.pictureId,
                    fit: BoxFit.fill,
                    width: 100,
                    errorBuilder: (ctx, error, _) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                // <-- Icon
                                Icons.place,
                                size: 20.0,
                              ), // <-- Text
                              const SizedBox(
                                width: 3,
                              ),
                              Text(restaurant.city,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,color: Colors.black54)),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                // <-- Icon
                                Icons.star,
                                color: Colors.amber,
                                size: 20.0,
                              ), // <-- Text
                              const SizedBox(
                                width: 3,
                              ),
                              Text('${restaurant.rating}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black54)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ))
          ]),
        ));
  }
}
