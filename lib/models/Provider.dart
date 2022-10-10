import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/auth/signin.dart';
import '../screens/homeScreen.dart';
import 'classModel.dart';

class ApiDB extends ChangeNotifier {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _accountNumberController = TextEditingController();

  TextEditingController get accountNumberController => _accountNumberController;

  TextEditingController get firstNameController => _firstNameController;

  TextEditingController get lastNameController => _lastNameController;

  TextEditingController get phoneNumberController => _phoneNumberController;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;
  var options;
  var token;
  late var phone;
  var userEmail;
  var firstname;
  var lastName;
  var Response;
  var accountNumber;
  Future<void> sharedPreferences() async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    phone = await storage.getString('phoneNumber');
    userEmail = await storage.getString('email');
    firstname = await storage.getString('firstName');
    lastName = await storage.getString('lastName');
    print(phone);
    print(userEmail);
    print(firstname);
    print(lastName);
    print(token);

    notifyListeners();
  }

  Future<void> dioSignUp(context) async {
    final dio = Dio(options);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      "Authorization": "Bearer $token",
    };

    var payload = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "phoneNumber": phoneNumberController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "accountNumber": accountNumberController.text,
    };
    notifyListeners();
    try {
      Response = await dio.post(
        'https://halat-mobile-bank-app.herokuapp.com/api/v1/createUser',
        data: payload,
        options: Options(
          headers: requestHeaders,
          contentType: 'application/json',
        ),
      );

      if (Response.statusCode == 200 || Response.statusCode == 201) {
        print('response: ${Response.data}');
        print('status:${Response.statusCode}');

        var responseData = Response.data;
        final storage = await SharedPreferences.getInstance();

        storage.setString('phoneNumber', phoneNumberController.text);
        storage.setString("firstName", firstNameController.text);
        storage.setString("lastName", lastNameController.text);
        storage.setString("email", emailController.text);
        storage.setString("password", passwordController.text);
        storage.setString("accountNumber", accountNumberController.text);
        var singlad = storage.getString("firstName");
        print("shared $singlad");
        notifyListeners();

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => SignIn()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Invalid details',
            ),
            duration: const Duration(
              seconds: 3,
            ),
          ),
        );
      }
    } catch (e, s) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Invalid details',
          ),
          duration: const Duration(
            seconds: 3,
          ),
        ),
      );
      print(e);
      print(s);
    }
  }

  Future<void> dioSignIn(context) async {
    var dio = Dio(options);

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      "Authorization": "Bearer $token",
    };
    var payLoad = {
      "phoneNumber": phoneNumberController.text,
      "password": passwordController.text,
    };
    try {
      Response = await dio.post(
        'https://halat-mobile-bank-app.herokuapp.com/api/v1/loginUser',
        data: payLoad,
        options: Options(
          headers: requestHeaders,
          contentType: 'application/json',
        ),
      );
      if (Response.statusCode == 200 || Response.statusCode == 201) {
        var responseData = Response.data;
        final storage = await SharedPreferences.getInstance();
        storage.setString('token', responseData['token']);
        storage.setString("phoneNumber", phoneNumberController.text);
        notifyListeners();
        dioRetrieve(context);
        var message = "User login successfully";
        if (responseData['message'] == message) {
          print("user loged in");
        } else {
          print('admin loggedin ');
        }

        //print('${responseData['token']}');

        print('response: ${Response.data}');
        print('status:${Response.statusCode}');
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
    } catch (e, s) {
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

      print(e);
      print(s);
    }
  }

  Future<ClassModel?> dioRetrieve(context) async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    notifyListeners();
    var dio = Dio(options);

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      "Authorization": "Bearer $token",
    };
    print("token: $token");
    try {
      var rep = await dio.get(
        'https://halat-mobile-bank-app.herokuapp.com/api/v1/retrieveUser?phoneNumber=${phoneNumberController.text.toString()}',
        options: Options(
          headers: requestHeaders,
          method: 'GET',
        ),
      );
      print('GEt response: ${rep.data}');
      print('Get status:${rep.statusCode}');

      if (rep.statusCode == 200 || rep.statusCode == 201) {
        var decodeData = rep.data;
        var responseData = ClassModel.fromJson(decodeData);
        accountNumber = responseData.getUser?.accountNumber;
        notifyListeners();
        print(accountNumber);
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => Homescreen()));
        // print('Decode Data: $decodeData');
      }
      notifyListeners();
    } catch (e, s) {
      print("get error: $e");
      print("get location: $s");
    }
  }
}

// using http package!!
// Future<void> postSignUp(context) async {
//   var url = Uri.parse('https://biggievet.herokuapp.com/api/user/register');
//   var token;
//   Map<String, String> requestHeaders = {
//     'Content-type': 'application/json',
//     'Accept': '*/*',
//   };
//   var payload = {
//     "name": "singlad2",
//     "phoneNumber": "0444444444227",
//     "password": "singlad1@",
//     "email": "singlad2@gmail.com"
//     // "name": nameController.text,
//     // "phoneNumber": phoneNumbercontroller,
//     // "password": passwordcontroller.text,
//     // "email": emailcontroller.text,
//   };
//   notifyListeners();
//   try {
//     var data = await http.post(
//       url,
//       headers: requestHeaders,
//       body: jsonEncode(payload),
//     );
//     if (data.statusCode == 200 || data.statusCode == 201) {
//       print('Response: ${data.statusCode}');
//       print('Response: ${data.body}');
//       notifyListeners();
//     } else {
//       throw 'error dey';
//     }
//   } catch (e, s) {
//     print(e);
//     print(s);
//   }
// }
//
// Future<void> postLogin() async {
//   var data;
//   var url = Uri.parse("https://biggievet.herokuapp.com//api/user/login");
//   Map<String, String> requestHeaders = {
//     'Content-type': 'application/json',
//     'Accept': '*/*',
//   };
//   var payload = {
//     "email": emailcontroller.text,
//     "password": passwordcontroller.text,
//   };
//
//   notifyListeners();
//   data = await http.post(
//     url,
//     headers: requestHeaders,
//     body: jsonEncode(payload),
//   );
// }
