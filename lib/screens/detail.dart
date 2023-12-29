import 'package:flutter/material.dart';
import 'package:restoran_app/models/restaurant.dart';

class Detail extends StatelessWidget {
  late Restaurant? restaurant;

  Detail({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(Object context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    restaurant!.pictureId,
                    fit: BoxFit.fill,
                    width: 100,
                  ),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant!.name,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w500),
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
                          Text(
                            restaurant!.city,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800),
                          ),
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
                          Text('${restaurant!.rating}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(restaurant!.description),
                  const SizedBox(height: 30),
                  const Text("Drinks :",
                      style:  TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 8,
                    runSpacing: 4,
                    children: (restaurant?.drinks as List).map((drink)  {
                    return Chip(label: Text(drink['name']));
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  const Text("Foods :",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 8,
                    runSpacing: 4,
                    children: (restaurant?.food as List).map((food) {
                      return Chip(label: Text(food['name']));
                    }).toList(),
                  ),
                          
                ],
              ),
            ),
          )),
    );
  }
}
