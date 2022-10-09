import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grazac_challenge3/screens/auth/signUp.dart';
import 'package:provider/provider.dart';

import '../../models/Provider.dart';
import '../../utilities/textfield.dart';
import '../homeScreen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;
  bool toggle = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var apiData = Provider.of<ApiDB>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Consumer<ApiDB>(
          builder: (context, snapshot, _) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 100, bottom: 20),
                      child: Text(
                        'WELCOME',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 24,
                          letterSpacing: 10,
                          shadows: [
                            Shadow(color: Colors.black, offset: Offset(0, 2)),
                          ],
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    kTextFormField(
                      hint: 'Phone Number',
                      errorMessage: '',
                      textEditingController: apiData.phoneNumberController,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter email address';
                        }
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

                      isPasswordType: true,
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
                                setState(() {
                                  loading = true;
                                });
                                Future.delayed(Duration(seconds: 4))
                                    .then((value) {
                                  setState(() {
                                    loading = false;
                                  });
                                });
                                try {
                                  await apiData
                                      .dioSignIn(context)
                                      .then((value) {
                                    if (apiData.rep == 200 ||
                                        apiData.rep == 201) {
                                      apiData.phoneNumberController.clear();
                                      apiData.passwordController.clear();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Homescreen()));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                            'wrong Phone Number or password',
                                          ),
                                          duration: const Duration(
                                            seconds: 5,
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                } catch (e, s) {
                                  print("error message: $e");
                                  print("error message: $s");
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Fill all the fields and accept the terms and conditions',
                                    ),
                                    duration: const Duration(
                                      seconds: 3,
                                    ),
                                  ),
                                );
                              }
                              setState(() {
                                loading = false;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'SignIn',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Dont have account already?'),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => SignUp()));
                          },
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
