import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app/data/api/api_service.dart';
import 'package:restoran_app/data/database/db_helper.dart';
import 'package:restoran_app/models/restaurant.dart';
import 'package:restoran_app/providers/resto_favorite.dart';

class FavoritBtn extends StatefulWidget{
   late String id;
   FavoritBtn({super.key, required this.id});

  @override
  State<FavoritBtn> createState() => FavoritBtnState();

}

class FavoritBtnState extends State<FavoritBtn>{
   bool favorit=false;
   DBHelper db =DBHelper();
   ApiService api=ApiService();

   @override
  void initState() {
    super.initState();
    checkFavorit();
  }

  @override
  Widget build(BuildContext context) {
   return Consumer<RestoFavoriteProvider>(
        builder: (context, state, child) {


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
          favorit?unFavorite():favorited();
          setState(() {
            state.fetchAllResto();
          });
        },
        // onHover:,
        child: Column(
            children: [
              Icon(
                  Icons.favorite,
                  color: (favorit? Colors.redAccent:Colors.black12)
              ),
              Text(
                  "favorite",
                  style: TextStyle(color: (favorit? Colors.redAccent:Colors.black12)
                  )
              )
            ]
        )
    );
        });
  }

 Future<void> unFavorite() async {
     await db.delete(widget.id);
     checkFavorit();
 }

 Future<void> favorited() async {
  Restaurant data = await api.getRestourantDetail(widget.id);
  await db.insert(data);
  checkFavorit();
 }

 Future<void> checkFavorit() async {
   List<Restaurant> result=await db.getById(widget.id);
   bool favdata=result.isNotEmpty;

   setState(() {
     favorit=favdata;
   });

 }
}