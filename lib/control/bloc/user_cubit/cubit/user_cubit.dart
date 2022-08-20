import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoptemp/helpers/api_helpert.dart';
import 'package:shoptemp/models/consts.dart';
import 'package:shoptemp/models/endpoints.dart';
import 'package:shoptemp/models/login_model.dart';
import 'package:shoptemp/views/widgets/showtoast.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState());

  static UserCubit get(BuildContext context) => BlocProvider.of(context);
  void loginUser(
      {required String email, required String password, String? tokken}) {
    emit(LoadingState());

    ApiHelper.postData(
        url: login,
        query: {},
        data: {"email": email, "password": password}).then((value) {
      if (value.data["status"]) {
        LoginModel loginData = LoginModel.fromMap(value.data);
        emit(UserLoginSuccessState(loginModel: loginData));
      } else{
        showToast(color: Colors.red, msg: value.data["message"]);
        
        }
    }).catchError((error) {
      showToast(color: Colors.red, msg: error.toString());
      emit(UserLoginErrorState());
    });
  }

  void registerUser(
      {required String email,
      required String name,
      required String phone,
      required String password,
      String? tokken}) {
    emit(UserLoadingState());

    ApiHelper.postData(url: "register", query: {}, data: {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password
    }).then((value) {
      profile = LoginModel.fromMap(value.data);
      emit(UserRegsterSuccessState(loginModel: profile!));
    }).onError((error, stackTrace) {
      emit(UserLoginErrorState());
    });
  }

  void editUser(
      {required String email,
      required String phone,
      required String password,
      required String name,
      String? tokken}) {
    emit(UserLoadingState());

    ApiHelper.putData(
        url: "update-profile",
        query: {},
        tokken: tokken,
        data: {
          "email": email,
          "phone": phone,
          "password": password,
          "name": name
        }).then((value) {
      LoginModel loginData = LoginModel.fromMap(value.data);
      emit(UserLoginSuccessState(loginModel: loginData));
    }).onError((error, stackTrace) {
      print(error.toString() + "sssss");
      emit(UserLoginErrorState());
    });
  }

  //settings
  LoginModel? profile;
  getProfile() {
    emit(UserLoadingState());

    ApiHelper.getData(url: "profile", quire: {}, token: token!).then((value) {
      profile = LoginModel.fromMap(value.data);
      emit(UserInitialState());
    }).onError((error, stackTrace) {
      emit(UserLoginErrorState());
    });
  }
}
