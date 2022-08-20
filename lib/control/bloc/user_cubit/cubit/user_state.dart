part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoginSuccessState extends UserState {
  final LoginModel loginModel;
  UserLoginSuccessState({required this.loginModel});
}

class UserLoginErrorState extends UserState {}

class UserLoadingState extends UserState {}

class LoadingState extends UserState {}

class UserRegsterSuccessState extends UserState {
  final LoginModel loginModel;
  UserRegsterSuccessState({required this.loginModel});
}

class UserRegsterErrorState extends UserState {}

class UserEditedSucessfully extends UserState {
  final LoginModel loginModel;
  UserEditedSucessfully({required this.loginModel});
}

class UserEditedError extends UserState {
  final String error;
  UserEditedError({required this.error});
}
