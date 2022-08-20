// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptemp/control/bloc/user_cubit/cubit/user_cubit.dart';
import 'package:shoptemp/helpers/cash_helper.dart';
import 'package:shoptemp/models/consts.dart';
import 'package:shoptemp/views/screens/login_screen.dart';
import 'package:shoptemp/views/screens/shoplayout/shoplayout.dart';
import 'package:shoptemp/views/widgets/input_field.dart';
import 'package:shoptemp/views/widgets/showtoast.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    return Scaffold(
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserRegsterSuccessState) {
            if (state.loginModel.status!) {
              showToast(
                color: Colors.green,
                msg: state.loginModel.message!,
              );

              CashHelper.setData("token", state.loginModel.data!.tokken)
                  .then((value) {
                token = state.loginModel.data!.tokken;
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const ShopLayout(),
                ));
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
          return Container(
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                  Colors.indigo.shade300,
                  Colors.indigo.shade50,
                  Colors.white
                ])),
            child: Form(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Signup",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            "Signup now and join our community",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          DefaultFormField(
                              hint: "beshoy",
                              label: "name",
                              textEditingController: nameController,
                              preIcon: Icons.person,
                              Suffix: null),
                          DefaultFormField(
                              hint: "beshoyfayz201@gmail.com",
                              label: "Email",
                              textEditingController: emailController,
                              preIcon: Icons.email,
                              Suffix: null),
                          DefaultFormField(
                              hint: "EG : 01551397516",
                              label: "phone",
                              textEditingController: phoneController,
                              preIcon: Icons.phone,
                              Suffix: null),
                          DefaultFormField(
                              hint: "Ex: ab2345cs",
                              label: "password",
                              textEditingController: passwordController,
                              preIcon: Icons.security,
                              Suffix: Icons.remove_red_eye),
                          Center(
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "dont have an account",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 23,
                                  )),
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = (() {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ));
                                    }),
                                  text: " Login",
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.brown.shade900,
                                  )),
                            ])),
                          ),
                          Center(
                            child: (State is! UserLoadingState)
                                ? Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                        Center(
                                          child: Image.asset(
                                            "assets/images/b.png",
                                            height: 200,
                                          ),
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
                                              "Signup",
                                              style: TextStyle(fontSize: 24),
                                            ),
                                            onPressed: () async {
                                              if (formkey.currentState!
                                                  .validate()) {
                                                UserCubit.get(context)
                                                    .registerUser(
                                                        name:
                                                            nameController.text,
                                                        email: emailController
                                                            .text,
                                                        phone: phoneController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text);
                                              }
                                            })
                                      ])
                                : Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
