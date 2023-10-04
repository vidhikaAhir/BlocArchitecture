import 'package:bloc/bloc.dart';
import 'package:bloc_arch_vidhika/Login/loginModel.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginLoaderEvent) {
        var response = await callLoginApi();
        print("TEST ==> ${response.runtimeType}");
        emit(LoginLoadingState(isLoader: true));
        if (response.runtimeType == String) {
          emit(LoginFailedState(data: response));
        } else if (response.runtimeType == FetchMyExpense) {
          emit(LoginSuccessState(response: response));
        }
      } else if (event is LoginSuccessfulEvent) {
      } else if (event is LoginFailedEvent) {
      } else if (event is LoginNavigateToDetailsEvent) {
        emit(LoginNavigateToDetailsState(selectedUser: event.selectedUser));
      }
    });
  }

  Future<dynamic> callLoginApi() async {
    final response =
        await http.get(Uri.parse("https://reqres.in/api/users?page=1"));
    debugPrint("Expense response--> ${response.body}");

    if (response.statusCode == 200) {
      var expenseResponse = FetchMyExpense.fromRawJson(response.body);
      debugPrint("Expense response in Model--> $expenseResponse");
      return expenseResponse;
    } else {
      return "Error: Problem fetching data";
    }
  }
}
