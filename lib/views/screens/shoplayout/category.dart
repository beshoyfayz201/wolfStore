import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptemp/control/bloc/shop_cubit/cubit/shop_cubit.dart';
import 'package:shoptemp/helpers/cash_helper.dart';
import 'package:shoptemp/models/category_model.dart';
import 'package:shoptemp/views/screens/login_screen.dart';
import 'package:shoptemp/views/widgets/categoryitem.dart';

class CategoryScreen extends StatelessWidget {
   CategoryScreen({Key? key}) : super(key: key);
 List<dynamic>? cats;
  @override
  Widget build(BuildContext context) {
   
    if (ShopCubit.get(context).categoryModel != null) {
      cats =
          ShopCubit.get(context).categoryModel!.categoryData!.categoryDataItem;
    }
    return (ShopCubit.get(context).categoryModel != null)?Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<ShopCubit, shopStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return ListView.builder(
                reverse: true,
                itemCount: cats!.length,
                itemBuilder: (context, index) => buidlItem(cats![index], index));
          },
        )):Center(child:CircularProgressIndicator());
  }

  buidlItem(CategoryDataItem categoryDataItem, int i) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 130,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 90,
            child: Card(
              color: Acolors[i % 4].withOpacity(0.7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(),
                  Text(categoryDataItem.name!,
                      style: TextStyle(fontSize: 22, fontFamily: "s")),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 4,
            left: 0,
            child: Image.network(
              categoryDataItem.image!,
              fit: BoxFit.fill,
              width: 100,
              height: 120,
            ),
          )
        ],
      ),
    );
  }
}
