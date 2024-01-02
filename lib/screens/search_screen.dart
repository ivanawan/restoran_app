import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/providers/search_resto_provider.dart';
import 'package:restoran_app/widgets/restaurant_card.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchRestoProvider(),
      child: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // var keyword = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Consumer<SearchRestoProvider>(builder: (context, state, _) {
                return TextField(
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      setState(() {
                        state.fetchSearchResto(text);
                      });
                    }
                  },
                  decoration: InputDecoration(
                      labelStyle: const TextStyle(fontSize: 20),
                      labelText: 'Search here',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17))),
                );
              }),
              const SizedBox(height: 20),
              Consumer<SearchRestoProvider>(builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.state == ResultState.hasData) {
                  return Column(
                      children: state.result.map((resto) {
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: RestaurantCard(data: resto));
                  }).toList());
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
              })
            ],
          )),
    );
  }
}
