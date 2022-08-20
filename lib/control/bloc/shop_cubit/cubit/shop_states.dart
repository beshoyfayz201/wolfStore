part of 'shop_cubit.dart';

abstract class shopStates {}

class BookshopInitial extends shopStates {}

class BottomNavBarState extends shopStates {}

class ShopLoadingState extends shopStates {}

class ShopSuccessState extends shopStates {}

class ShopErrorState extends shopStates {
 final String error;
  ShopErrorState({required this.error});
}

class CategorySuccessState extends shopStates {}

class CategoryErrorState extends shopStates {
  String error;
  CategoryErrorState({required this.error});
}
//
//
//

class FavouriteChangedState extends shopStates {}

class FavoriteChangeError extends shopStates {
 final String error;
  FavoriteChangeError({required this.error});
}
