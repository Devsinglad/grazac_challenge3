import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grazac_challenge3/models/Provider.dart';
import 'package:grazac_challenge3/screens/auth/signin.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utilities/textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  bool toggle = true;
  bool condition = true;

  final _formKey = GlobalKey<FormState>();

  String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      return 'Password is required.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    var apiData = Provider.of<ApiDB>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Consumer<ApiDB>(
          builder: (context, snapshot, _) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kTextFormField(
                        hint: 'First Name',
                        textEditingController: apiData.firstNameController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "field can't be empty";
                          }
                        },
                        isPasswordType: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      kTextFormField(
                        hint: 'Last Name',
                        textEditingController: apiData.lastNameController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "field can't be empty";
                          }
                        },
                        isPasswordType: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      kTextFormField(
                        hint: 'Email address',
                        errorMessage: '',
                        textEditingController: apiData.emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter email address';
                          }
                          if (!value.contains('@gmail.com')) {
                            return "enter a valid email address";
                          }
                        },
                        isPasswordType: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      kTextFormField(
                        hint: 'phone Number',
                        errorMessage: '',
                        textEditingController: apiData.phoneNumberController,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter phone Number';
                          }
                          // if (value.contains('')) {
                          //   return "enter a valid Phone Number";
                          // }
                        },
                        isPasswordType: false,
                      ),
                      kTextFormField(
                        hint: "password",
                        textEditingController: apiData.passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: toggle,
                        //icon: Icons.lock,
                        passwordIcon: GestureDetector(
                          onTap: () {
                            if (toggle == true) {
                              setState(() {
                                toggle = false;
                              });
                            } else {
                              setState(() {
                                toggle = true;
                              });
                            }
                          },
                          child: toggle == true
                              ? Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                ),
                        ),
                        validator: validatePassword,
                        isPasswordType: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      kTextFormField(
                        hint: 'Account Number',
                        textEditingController: apiData.accountNumberController,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "field can't be empty";
                          }
                        },
                        isPasswordType: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      loading
                          ? CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                Color(0xff5771F9),
                              ),
                            )
                          : InkWell(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState?.save();
                                  setState(() {
                                    loading = true;
                                  });
                                  Future.delayed(Duration(seconds: 4))
                                      .then((value) {
                                    setState(() {
                                      loading = false;
                                    });
                                  });
                                  await apiData.dioSignUp(context);
                                }
                              },
                              child: Container(
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => SignUp()));
                                    },
                                    child: Text(
                                      'SignUp',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
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
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => SignIn()));
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'SignIn',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
