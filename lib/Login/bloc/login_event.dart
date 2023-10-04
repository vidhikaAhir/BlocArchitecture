part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginLoaderEvent extends LoginEvent {
  final int page;

  LoginLoaderEvent({required this.page});
}

class LoginNavigateToDetailsEvent extends LoginEvent {
  final Datum selectedUser;

  LoginNavigateToDetailsEvent({required this.selectedUser});
}

class LoginSuccessfulEvent extends LoginEvent {}

class LoginFailedEvent extends LoginEvent {}
