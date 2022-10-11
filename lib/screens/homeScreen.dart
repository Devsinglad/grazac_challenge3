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
  @override
  Widget build(BuildContext context) {
    var apiData = Provider.of<ApiDB>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'PROFILE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 300,
                      height: 135,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Positioned(
                      left: 120,
                      bottom: 100,
                      child: Container(
                        height: 68,
                        width: 65.4,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 50,
                      top: 50,
                      child: Row(
                        children: [
                          Text(
                            'Full Name: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            apiData.firstname.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            apiData.lastName.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 80,
                      child: Text(
                        " Account Number: ${apiData.accountNumber.toString()}",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
