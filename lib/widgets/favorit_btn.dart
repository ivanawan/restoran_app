import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/providers/resto_favorite.dart';

class FavoritBtn extends StatelessWidget{
   late String id;
   FavoritBtn({super.key, required this.id});

   @override
   Widget build(BuildContext context) {
     return Consumer<RestoFavoriteProvider>(
         builder: (context, state, child) {
           state.checkFavorit(id);
           return  ElevatedButton(
               style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.white,
                   foregroundColor: Colors.white,
                   shadowColor: Colors.white,
                   surfaceTintColor: Colors.white,
                   disabledBackgroundColor: Colors.white,
                   disabledForegroundColor: Colors.white
               ),
               onPressed: (){
                 state.favorite? state.unFavorite(id):state.favorited(id);
               },
               // onHover:,
               child: Column(
                   children: [
                     Icon(
                         Icons.favorite,
                         color: (state.favorite? Colors.redAccent:Colors.black12)
                     ),
                     Text(
                         "favorite",
                         style: TextStyle(color: (state.favorite? Colors.redAccent:Colors.black12)
                         )
                     )
                   ]
               )
           );
         });
   }

}