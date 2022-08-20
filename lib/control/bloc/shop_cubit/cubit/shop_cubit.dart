import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptemp/control/bloc/user_cubit/cubit/user_cubit.dart';
import 'package:shoptemp/helpers/api_helpert.dart';
import 'package:shoptemp/models/category_model.dart';
import 'package:shoptemp/models/consts.dart';
import 'package:shoptemp/models/home_model.dart';
import 'package:shoptemp/models/login_model.dart';
import 'package:shoptemp/views/screens/shoplayout/product_screen.dart';
import 'package:shoptemp/views/screens/shoplayout/category.dart';
import 'package:shoptemp/views/screens/shoplayout/favourite.dart';
import 'package:shoptemp/views/screens/shoplayout/settings.dart';
import 'package:shoptemp/views/widgets/showtoast.dart';

part 'shop_states.dart';

class ShopCubit extends Cubit<shopStates> {
  int currentIndex = 0;
  //for real time we make a temp map
  //so that in realtime Change we got it from a (map) but in app logic we Change the api data
  Map<int, bool>? favourites = {};

  ShopCubit() : super(BookshopInitial());
  static ShopCubit get(BuildContext context) => BlocProvider.of(context);
  List<Widget> screens = [
    productScreen(),
    FavouriteScreen(),
    SettingsScreen(),
    CategoryScreen(),
  ];
  void changeIndex(int index) {
    currentIndex = index;
    emit(BottomNavBarState());
  }

  HomeModel? homeModel;
//get all home Data
  getHomeData({required String token}) async {
    emit(ShopLoadingState());
    ApiHelper.getData(url: "home", quire: {}, token: token).then((value) {
      if (value.data['status']) {
        homeModel = HomeModel.formMap(value.data);

        homeModel!.homeDataModel.products.forEach((element) {
          favourites!.addAll({element.id!: element.isFavorite!});
        });
        emit(ShopSuccessState());
      }
    }).onError((error, stackTrace) {
      emit(ShopErrorState(error: error.toString()));
    });
  }

  CategoryModel? categoryModel; //to get categories
  getCategories(String token) async {
    ApiHelper.getData(url: "categories", quire: {}, token: token).then((value) {
      categoryModel = CategoryModel.fromMap(value.data);
      emit(CategorySuccessState());
    }).onError((error, stackTrace) {
      emit(CategoryErrorState(error: error.toString()));
    });
  }

  updateFavorite(int id, String token, BuildContext context) {
    favourites![id] = !favourites![id]!;
    ApiHelper.postData(url: "favorites", tokken: token, query: {}, data: {
      "product_id": id,
    }).then((value) {
      //fail due to bad request
      if (!value.data["status"]) {
        favourites![id] = !favourites![id]!;
        showToast(
          color: Colors.red,
          msg: value.data["message"],
        );
        emit(FavoriteChangeError(error: "ss"));
      }

      showToast(
        color: Colors.green,
        msg: value.data["message"],
      );
    }).onError((error, stackTrace) {
      //fail due to exception
      showToast(color: Colors.red, msg: error.toString());
      favourites![id] = !favourites![id]!;
      emit(FavoriteChangeError(error: error.toString()));
    });

    emit(FavouriteChangedState());
  }

  getFavouritesList() {
    List<ProductModel> prods = homeModel!.homeDataModel.products
        .where((element) => favourites![element.id]!)
        .toList();

    emit(ShopSuccessState());
    return prods;
  }

  deleteItemFormFavorites(int id) {
    favourites![id] = false;
    emit(ShopSuccessState());
  }

 
}
