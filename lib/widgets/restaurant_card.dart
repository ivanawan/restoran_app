import 'package:flutter/material.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:restoran_app/screens/detail.dart';

class RestaurantCard extends StatelessWidget{
  late Restaurant data;
  RestaurantCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
   return GestureDetector(
       onTap: () {
         // Navigator.push(context, Detail(restaurant: restaurant));
         Navigator.of(context).push(
           MaterialPageRoute(
             builder: (context) => Detail(id: data.id),
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
                  'https://restaurant-api.dicoding.dev/images/small/${data.pictureId}',
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
                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                 child: Column(
                   children: [
                     Text(
                       data.name,
                       style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
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
                             Text(data.city,
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
                             Text('${data.rating}',
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