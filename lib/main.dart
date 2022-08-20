import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptemp/control/bloc/shop_cubit/cubit/shop_cubit.dart';
import 'package:shoptemp/control/bloc/user_cubit/cubit/user_cubit.dart';
import 'package:shoptemp/helpers/api_helpert.dart';
import 'package:shoptemp/helpers/cash_helper.dart';
import 'package:shoptemp/models/consts.dart';
import 'package:shoptemp/views/screens/login_screen.dart';
import 'package:shoptemp/views/screens/onboarding_screen.dart';
import 'package:shoptemp/views/screens/shoplayout/shoplayout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ApiHelper.init();
  await CashHelper.init();
  late Widget startWidget;
  bool onBoarding = (CashHelper.getData("onBoarding")) ?? false;
  token = CashHelper.getData("token");
  print("---------------" + token.toString());
  if (!onBoarding) {
    startWidget = OnBoarding();
  } else if (token == null) {
    startWidget = LoginScreen();
  } else {
    startWidget = const ShopLayout();
  }

  runApp(MyApp(startWidget: startWidget));
}

//
class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // ignore: sort_child_properties_last
      child: MaterialApp(
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
              actionsIconTheme: IconThemeData(color: Colors.black),
              color: Colors.white,
              titleTextStyle: TextStyle(
                  fontSize: 30, fontFamily: "calist", color: Colors.black),
              elevation: 0,
            ),
            fontFamily: "calist",
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.black)),
        home: startWidget,
      ),
      providers: [
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData(token: token ?? "")
              ..getCategories(token ?? "")),
        BlocProvider(create: (context) => UserCubit())
      ],
    );
  }
}
