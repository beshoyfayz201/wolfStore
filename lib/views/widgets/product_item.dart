import 'package:flutter/material.dart';
import 'package:ribbon_widget/ribbon_widget.dart';
import 'package:shoptemp/control/bloc/shop_cubit/cubit/shop_cubit.dart';
import 'package:shoptemp/models/consts.dart';
import 'package:shoptemp/models/home_model.dart';

class ProductGridTile extends StatelessWidget {
  final ProductModel productModel;
  final bool fav;
  const ProductGridTile(
      {Key? key, required this.productModel, required this.fav})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool withOffer = (productModel.oldPrice != productModel.price);
    ShopCubit shopCubit = ShopCubit.get(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Ribbon(
            nearLength: withOffer ? 30 : 1,
            farLength: withOffer ? 50 : 0,
            titleStyle: TextStyle(
                fontStyle: FontStyle.italic,
                color: (productModel.oldPrice != productModel.price)
                    ? Colors.white
                    : Colors.transparent),
            color: (withOffer) ? Colors.black : Colors.white,
            title: "offer",
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    productModel.image!,
                    height: MediaQuery.of(context).size.height * 0.22,
                  ),
                  Text(
                    productModel.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(productModel.price.toString() + "\$",
                          style: TextStyle(
                            color: withOffer ? Colors.red : Colors.black,
                            fontSize: 16,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      if (withOffer)
                        Text(productModel.oldPrice.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontSize: 14)),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 1,
            right: 1,
            child: IconButton(
                onPressed: () {
                  shopCubit.updateFavorite(productModel.id!, token!, context);
                },
                icon: Icon(
                  !ShopCubit.get(context).favourites![productModel.id]!
                      ? Icons.favorite_border
                      : Icons.favorite,
                  size: 20,
                )),
          ),
        ],
      ),
    );
  }
}
