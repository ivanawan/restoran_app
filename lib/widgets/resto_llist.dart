import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/providers/resto_provider.dart';
import 'package:restoran_app/widgets/restaurant_card.dart';

class RestoList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Consumer<RestoProvider>(builder: (context,state, _){
      if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.hasData) {
        return Column(
                    children: state.result.map((resto)  {
                      return Padding(padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),child:RestaurantCard(data: resto));
                    }).toList()
                );
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
    });
  }

}