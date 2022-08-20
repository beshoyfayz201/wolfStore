import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoptemp/control/bloc/user_cubit/cubit/user_cubit.dart';
import 'package:shoptemp/helpers/cash_helper.dart';
import 'package:shoptemp/models/consts.dart';
import 'package:shoptemp/size_config.dart';
import 'package:shoptemp/views/screens/shoplayout/shoplayout.dart';
import 'package:shoptemp/views/screens/signup_screen.dart';
import 'package:shoptemp/views/widgets/input_field.dart';
import 'package:shoptemp/views/widgets/showtoast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
              Colors.indigo.shade200,
              Colors.indigo.shade50,
              Colors.white
            ])),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.19,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is UserLoginSuccessState) {
                    if (state.loginModel.status!) {
                      showToast(
                        color: Colors.green,
                        msg: state.loginModel.message!,
                      );

                      CashHelper.setData("token", state.loginModel.data!.tokken)
                          .then((value) {
                        token = state.loginModel.data!.tokken;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ShopLayout(),
                        ));
                      });
                    } else {
                      showToast(
                        color: Colors.red,
                        msg: state.loginModel.message!,
                      );
                      print("object");
                    }
                  }
                },
                builder: (context, state) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          "Login now and browse or hot offers",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        DefaultFormField(
                            hint: "beshoyfayz201@gmail.com",
                            label: "Email",
                            textEditingController: emailController,
                            preIcon: Icons.email,
                            Suffix: null),
                        DefaultFormField(
                            hint: "Ex: ab2345cs",
                            label: "password",
                            textEditingController: passwordController,
                            preIcon: Icons.security,
                            Suffix: Icons.remove_red_eye),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Center(
                              child: Image.asset(
                                "assets/images/b.png",
                                height: 300,
                              ),
                            ),
                            Center(
                              child: (state is! LoadingState)
                                  ? ElevatedButton(
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
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          UserCubit.get(context).loginUser(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                        }
                                      })
                                  : const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: CircularProgressIndicator(),
                                    ),
                            ),
                          ],
                        ),
                        Center(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "dont have an account",
                                style: TextStyle(
                                  color: Colors.grey.shade200,
                                  fontSize: 23,
                                )),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = (() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignupScreen(),
                                        ));
                                  }),
                                text: " Sign-Up",
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.blue.shade900,
                                )),
                          ])),
                        ),
                      ]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
