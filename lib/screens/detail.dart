import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/providers/detail_resto_provider.dart';
import 'package:restoran_app/widgets/favorit_btn.dart';

class Detail extends StatefulWidget {
  late String id;
  Detail({super.key, required this.id});

  @override
  State<Detail> createState() => DetailData();
}

class DetailData extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestoProvider>(
      create: (_) => DetailRestoProvider(id: widget.id),
      child: consumerWidget(),
    );
  }

  Widget consumerWidget() {
    return Scaffold(
        body: Consumer<DetailRestoProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.hasData) {
        return NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      'https://restaurant-api.dicoding.dev/images/medium/${state.result.pictureId}',
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
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.result.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        FavoritBtn(id: state.result.id)
                      ],
                    ),
                    const SizedBox(height: 30),
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
                              state.result.city,
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
                            Text('${state.result.rating}',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(state.result.description ?? ''),
                    const SizedBox(height: 30),
                    const Text("Drinks :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 10),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 8,
                      runSpacing: 4,
                      children:
                          (state.result.menu?.drinks as List).map((drink) {
                        return Chip(label: Text(drink.name));
                      }).toList(),
                    ),
                    const SizedBox(height: 10),
                    const Text("Foods :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w800)),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 8,
                      runSpacing: 4,
                      children: (state.result.menu?.foods as List).map((food) {
                        return Chip(label: Text(food.name));
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ));
      } else if (state.state == ResultState.noData) {
        return Center(
          child: Material(
            child: Text(state.message),
          ),
        );
      } else if (state.state == ResultState.error) {
        return Center(
          child: Material(
            child: Text(state.message),
          ),
        );
      } else {
        return const Center(
          child: Material(
            child: Text(''),
          ),
        );
      }
    }));
  }
}
