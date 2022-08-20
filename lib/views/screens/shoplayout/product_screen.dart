import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoptemp/control/bloc/shop_cubit/cubit/shop_cubit.dart';
import 'package:shoptemp/models/category_model.dart';
import 'package:shoptemp/models/home_model.dart';
import 'package:shoptemp/views/widgets/categoryitem.dart';
import 'package:shoptemp/views/widgets/product_item.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class productScreen extends StatelessWidget {
  productScreen({Key? key}) : super(key: key);
  SwipeableCardSectionController sc = SwipeableCardSectionController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocConsumer<ShopCubit, shopStates>(
        builder: (context, state) {
          if (state is ShopLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return (ShopCubit.get(context).homeModel != null &&
                    ShopCubit.get(context).categoryModel != null)
                ? builGridView(
                    context,
                    ShopCubit.get(context).homeModel!,
                    ShopCubit.get(context).categoryModel!,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }
        },
        listener: (context, state) {},
      ),
    );
  }

  builGridView(
      BuildContext context, HomeModel homeModel, CategoryModel categoryModel) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CarouselSlider(
              items: List.generate(
                  homeModel.homeDataModel.banners.length,
                  (index) => Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                              homeModel.homeDataModel.banners[index].image!,
                              fit: BoxFit.fill,
                              width: double.infinity),
                        ),
                      )),
              options: CarouselOptions(
                  viewportFraction: 0.8,
                  padEnds: true,
                  pageSnapping: false,
                  disableCenter: true,
                  autoPlayCurve: Curves.linear,
                  enableInfiniteScroll: true,
                  aspectRatio: 2,
                  enlargeCenterPage: true,
                  autoPlay: true),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.15,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    width: 5,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      categoryModel.categoryData!.categoryDataItem.length,
                  itemBuilder: (context, index) => CategoryWidget(
                      categoryDataItem:
                          categoryModel.categoryData!.categoryDataItem[index],
                      index: index),
                )),
            StaggeredGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 12,
                children: List.generate(
                  homeModel.homeDataModel.products.length,
                  (index) => StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: index.isEven ? 1.5 : 1.6,
                    child: ProductGridTile(
                      productModel: homeModel.homeDataModel.products[index],
                      fav: false,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
