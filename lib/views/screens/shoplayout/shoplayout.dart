import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptemp/control/bloc/shop_cubit/cubit/shop_cubit.dart';
import 'package:shoptemp/helpers/cash_helper.dart';
import 'package:shoptemp/size_config.dart';
import 'package:shoptemp/views/screens/login_screen.dart';
import 'package:shoptemp/views/screens/shoplayout/search_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);
  final List<BottomNavigationBarItem> bottomNavs = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.storefront_sharp),
      label: "",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline_outlined),
      label: "",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list_alt_sharp),
      label: "",
    )
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    ShopCubit shopCubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, shopStates>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              titleSpacing: 10,
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("Wolf Store"),
                Image.asset(
                  "assets/images/b.png",
                  height: 70,
                ),
              ]),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchScreen()));
                    },
                    icon: Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      CashHelper.sharedPreferences!
                          .remove("token")
                          .then((value) {
                        if (value) {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                        }
                      });
                    },
                    icon: Icon(Icons.exit_to_app))
              ]),
          body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFBBDEFB), Colors.green.shade100])),
              child: shopCubit.screens[shopCubit.currentIndex]),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavs,
            onTap: ((value) {
              shopCubit.changeIndex(value);
            }),
            currentIndex: shopCubit.currentIndex,
          ),
        );
      },
    );
  }
}
