import 'package:bloc_arch_vidhika/Login/loginModel.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final Datum selectedUser;

  const DetailsScreen({super.key, required this.selectedUser});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint("Printing selected user ==> ${widget.selectedUser}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          Image.network(widget.selectedUser.avatar ?? ""),
          Text("Name ${widget.selectedUser.firstName}")
        ]),
      ),
    );
  }
}
