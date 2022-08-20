// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptemp/control/bloc/shop_cubit/cubit/shop_cubit.dart';
import 'package:shoptemp/control/bloc/user_cubit/cubit/user_cubit.dart';
import 'package:shoptemp/helpers/cash_helper.dart';
import 'package:shoptemp/models/consts.dart';
import 'package:shoptemp/models/login_model.dart';
import 'package:shoptemp/size_config.dart';
import 'package:shoptemp/views/widgets/input_field.dart';
import 'package:shoptemp/views/widgets/showtoast.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..getProfile(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          print(state);
          if (state is UserEditedSucessfully) {
            if (state.loginModel.status!) {
              showToast(
                color: Colors.green,
                msg: state.loginModel.message!,
              );

              CashHelper.setData("token", state.loginModel.data!.tokken)
                  .then((value) {
                token = state.loginModel.data!.tokken;
              });
            } else {
              showToast(
                color: Colors.red,
                msg: state.loginModel.message!,
              );
            }
          }
        },
        builder: (context, state) {
          return (UserCubit.get(context).profile == null)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.screenHeight * 0.05,
                          ),
                          DefaultFormField(
                              hint: UserCubit.get(context).profile!.data!.name,
                              label: "name",
                              textEditingController: nameController,
                              preIcon: Icons.person,
                              Suffix: Icons.remove_red_eye),
                          DefaultFormField(
                              hint: UserCubit.get(context).profile!.data!.email,
                              label: "Email",
                              textEditingController: emailController,
                              preIcon: Icons.email,
                              Suffix: null),
                          DefaultFormField(
                              hint: UserCubit.get(context).profile!.data!.phone,
                              label: "phone",
                              textEditingController: phoneController,
                              preIcon: Icons.phone,
                              Suffix: null),
                          DefaultFormField(
                              hint: "xxxxxx",
                              label: "password",
                              textEditingController: passwordController,
                              preIcon: Icons.security,
                              Suffix: Icons.remove_red_eye),
                          Center(
                            child: (State is! LoadingState)
                                ? Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Image.asset(
                                        "assets/images/edit.png",
                                        height: 200,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.5,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10)),
                                          child: Text(
                                            "Edit user",
                                            style: TextStyle(fontSize: 24),
                                          ),
                                          onPressed: () async {
                                            UserCubit.get(context).editUser(
                                                email: emailController.text,
                                                phone: phoneController.text,
                                                name: nameController.text,
                                                password:
                                                    passwordController.text,
                                                tokken: token);
                                          }),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: CircularProgressIndicator(),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
