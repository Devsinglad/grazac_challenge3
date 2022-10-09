import 'package:flutter/material.dart';
import 'package:grazac_challenge3/models/Provider.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 0)).then((value) {
      var apiData = Provider.of<ApiDB>(context);
      apiData.dioRetrieve(context);
      apiData.sharedPreferences();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var apiData = Provider.of<ApiDB>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 200,
              width: 300,
              color: Colors.red,
              child: Text(apiData.firstname.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
