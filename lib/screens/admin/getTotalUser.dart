import 'package:flutter/material.dart';
import 'package:grazac_challenge3/screens/auth/signin.dart';
import 'package:provider/provider.dart';

import '../../models/Provider.dart';

class TotalUser extends StatefulWidget {
  const TotalUser({Key? key}) : super(key: key);

  @override
  State<TotalUser> createState() => _TotalUserState();
}

class _TotalUserState extends State<TotalUser> {
  @override
  Widget build(BuildContext context) {
    var apiData = Provider.of<ApiDB>(context, listen: true);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.purple.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "TOTAL USER: ${apiData.total.toString()}",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => SignIn()));
            },
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 80,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(0, 3),
                        blurRadius: 0.5,
                      )
                    ]),
                child: Center(
                  child: Text(
                    "LOG OUT",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
