import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoptemp/control/bloc/shop_cubit/cubit/shop_cubit.dart';
import 'package:shoptemp/models/home_model.dart';

import 'package:shoptemp/views/widgets/product_item.dart';
import 'package:shoptemp/views/widgets/title_widget.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({Key? key}) : super(key: key);
  List<ProductModel>? prods;

  @override
  Widget build(BuildContext context) {
    ShopCubit shopCubit = ShopCubit.get(context);
    prods = shopCubit.getFavouritesList();

    return Container(
        child: BlocConsumer<ShopCubit, shopStates>(
      listener: (context, state) {
        if (state is FavouriteChangedState ||
            state is BottomNavBarState ||
            state is FavoriteChangeError) {
          prods = shopCubit.getFavouritesList();
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              title(txt: "your favorites"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: (prods!.length == 0)
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/noitems.png",
                            height: 300,
                          ),
                          Text(
                            "you have no Favorites yet",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 40, color: Colors.black54),
                          )
                        ],
                      )
                    : StaggeredGrid.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 12,
                        children: List.generate(
                          prods!.length,
                          (index) => StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: index % 3 == 0
                                ? 2.1
                                : index % 3 == 1
                                    ? 2.2
                                    : 2.3,
                            child: ProductGridTile(
                                productModel: prods![index], fav: true),
                          ),
                        )),
              )
            ],
          ),
        );
      },
    ));
  }
}
