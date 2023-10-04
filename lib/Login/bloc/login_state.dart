part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {
  final bool isLoader;

  LoginLoadingState({required this.isLoader});
}

class LoginSuccessState extends LoginState {
  final FetchMyExpense response;

  LoginSuccessState({required this.response});
}

class LoginFailedState extends LoginState {
  final String data;

  LoginFailedState({required this.data});
}

class LoginNavigateToDetailsState extends LoginState {
  final Datum selectedUser;

  LoginNavigateToDetailsState({required this.selectedUser});
}
