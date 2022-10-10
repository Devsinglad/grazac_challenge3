import 'package:flutter/material.dart';
import 'package:grazac_challenge3/models/Provider.dart';
import 'package:grazac_challenge3/models/classModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var token;
  var phone;
  var userEmail;
  var firstname;
  var lastName;
  var Response;
  var condition;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 0)).then((value) {
      var apiData = Provider.of<ApiDB>(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var apiData = Provider.of<ApiDB>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                print(phone);
              },
              child: Text(
                apiData.accountNumber.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
