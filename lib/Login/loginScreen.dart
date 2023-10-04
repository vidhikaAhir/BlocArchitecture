import 'package:bloc_arch_vidhika/Details/detailsScreen.dart';
import 'package:bloc_arch_vidhika/Login/bloc/login_bloc.dart';
import 'package:bloc_arch_vidhika/Login/loginModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: Scaffold(
            appBar: AppBar(),
            body:
                BlocConsumer<LoginBloc, LoginState>(builder: (context, state) {
              return Builder(builder: (context) {
                if (state is LoginSuccessState) {
                  return mainUI(state.response);
                } else if (state is LoginFailedState) {
                  return error();
                } else {
                  return loader(context);
                }
              });
            }, listenWhen: (context, state) {
              if (state is LoginNavigateToDetailsState) {
                return true;
              } else {
                return false;
              }
            }, listener: (context, state) {
              if (state is LoginNavigateToDetailsState) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailsScreen(selectedUser: state.selectedUser)));
              }
            })));
  }

  Widget loader(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          EasyLoading.show(status: "Loading");
          Future.delayed(const Duration(seconds: 2));
          BlocProvider.of<LoginBloc>(context).add(LoginLoaderEvent(page: 1));
        },
        child: const Text("Click for API"),
      ),
    );
  }

  Widget mainUI(
    FetchMyExpense expenseList,
  ) {
    EasyLoading.dismiss();
    var data = expenseList.data;
    return Center(
        child: ListView.builder(
            itemCount: data?.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<LoginBloc>(context).add(
                      LoginNavigateToDetailsEvent(selectedUser: data![index]));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(data?[index].firstName ?? ""),
                      const Spacer(),
                      Image.network(data?[index].avatar ?? "")
                    ],
                  ),
                ),
              );
            }));
  }

  Widget error() {
    EasyLoading.dismiss();
    return Center(
        child: Image.asset(
      "assets/error.png",
      width: 100,
      height: 100,
    ));
  }
}
