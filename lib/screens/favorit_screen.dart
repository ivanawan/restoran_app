import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/providers/resto_favorite.dart';
import 'package:restoran_app/screens/search_screen.dart';
import 'package:restoran_app/widgets/resto_llist_favorit.dart';


class FavoritScreen extends StatelessWidget {
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
                        onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SearchScreen(),
                            ),
                          );
                        }, icon: const Icon(Icons.search,size: 30,weight:500))
                  ],
                ),
                const SizedBox(
                  height: 100,
                  child: ListTile(
                    title: Text(
                      'Favorites',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                ChangeNotifierProvider<RestoFavoriteProvider>(
                  create:(_)=> RestoFavoriteProvider(),
                  child:  RestoListFavorit(),
                ),
              ],
            )
        )
    );
  }

}
