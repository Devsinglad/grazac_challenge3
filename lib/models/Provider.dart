import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:grazac_challenge3/models/TotalUserModel.dart';
import 'package:grazac_challenge3/models/getUserModel.dart';
import 'package:grazac_challenge3/screens/admin/adminScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/admin/getTotalUser.dart';
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
  var AdminResponse;
  var AdminStatus;
  var accountNumber;
  var UserFirstName;
  var total;
  bool isLoading = false;
  List<Map<String, dynamic>> demoData = [];

  // Future<void> sharedPreferences() async {
  //   final storage = await SharedPreferences.getInstance();
  //   token = await storage.getString('token');
  //   phone = storage.getString('phoneNumber');
  //   userEmail = storage.getString('email');
  //   firstname = storage.getString('firstName');
  //   lastName = storage.getString('lastName');
  //   print(phone);
  //   print(userEmail);
  //   print(firstname);
  //   print(lastName);
  //   print(token);
  //
  //   notifyListeners();
  // }

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

        phone = storage.getString('phoneNumber');
        userEmail = storage.getString('email');
        firstname = storage.getString('firstName');
        lastName = storage.getString('lastName');
        print("shared $phone");
        print("shared $userEmail");
        print("shared $firstname");
        print("shared $lastName");

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

        print('response: ${Response.data}');
        print('status:${Response.statusCode}');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Invalid Details',
            ),
            duration: const Duration(
              seconds: 5,
            ),
          ),
        );
      }
    } catch (e, s) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Invalid Details',
          ),
          duration: const Duration(
            seconds: 7,
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

  Future<void> dioAdminSignIn(context) async {
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
      AdminResponse = await dio.post(
        'https://halat-mobile-bank-app.herokuapp.com/api/v1/loginAdmin',
        data: payLoad,
        options: Options(
          headers: requestHeaders,
          contentType: 'application/json',
        ),
      );

      if (AdminResponse.statusCode == 200 || AdminResponse.statusCode == 201) {
        notifyListeners();
        // dioRetrieve(context);
        var responseData = AdminResponse.data;
        final storage = await SharedPreferences.getInstance();
        storage.setString('token', responseData['token']);
        storage.setString("phoneNumber", phoneNumberController.text);
        notifyListeners();
        print('response: ${AdminResponse.data}');
        print('status:${AdminResponse.statusCode}');
        Navigator.push(context, MaterialPageRoute(builder: (_) => AdminPage()));
        notifyListeners();
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
      if (AdminResponse != Response) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'User logged in ',
            ),
            duration: const Duration(
              seconds: 3,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Invalid Details ',
            ),
            duration: const Duration(
              seconds: 3,
            ),
          ),
        );
      }
      print(e);
      print(s);
    }
  }

  Future<GetUserModel?> AdminGetUser(context) async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    notifyListeners();
    var dio = Dio(options);

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      "Authorization": "Bearer $token",
    };

    try {
      isLoading = true;
      notifyListeners();
      var rep = await dio.get(
        'https://halat-mobile-bank-app.herokuapp.com/api/v1/getAllUsers',
        options: Options(
          headers: requestHeaders,
          method: 'GET',
        ),
      );
      // print('Get status:${rep.statusCode}');
      // print('GEt response: ${rep.data}');

      if (rep.statusCode == 200 || rep.statusCode == 201) {
        isLoading = false;
        //responseData = GetUserModel.fromJson(decodeData);
        demoData.clear();
        demoData.add(rep.data);

        print(demoData);

        notifyListeners();
      }

      notifyListeners();
    } catch (e, s) {
      throw Exception('something went wrong: $e');
    }
  }

  Future<void> AdminBlockUser(context) async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    notifyListeners();
    var dio = Dio(options);

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      "Authorization": "Bearer $token",
    };

    try {
      isLoading = true;
      notifyListeners();
      var rep = await dio.patch(
        'https://halat-mobile-bank-app.herokuapp.com/api/v1/block?email=${emailController.text}',
        options: Options(
          headers: requestHeaders,
          method: 'PATCH',
        ),
      );
      print('Get status:${rep.statusCode}');
      print('GEt response: ${rep.data}');

      if (rep.statusCode == 200 || rep.statusCode == 201) {
        isLoading = false;

        notifyListeners();
      }

      notifyListeners();
    } catch (e, s) {
      throw Exception('something went wrong: $e');
    }
  }

  // Future<GetUserTotalModel?> AdminGetTotalUser(context) async {
  //   final storage = await SharedPreferences.getInstance();
  //   token = await storage.getString('token');
  //   notifyListeners();
  //   var dio = Dio(options);
  //
  //   Map<String, String> requestHeaders = {
  //     'Content-type': 'application/json',
  //     'Accept': '*/*',
  //     "Authorization": "Bearer $token",
  //   };
  //
  //   try {
  //     isLoading = true;
  //     notifyListeners();
  //     var rep = await dio.get(
  //       'https://halat-mobile-bank-app.herokuapp.com/api/v1/countUsers',
  //       options: Options(
  //         headers: requestHeaders,
  //         method: 'GET',
  //       ),
  //     );
  //     // print('Get status:${rep.statusCode}');
  //     // print('GEt response: ${rep.data}');
  //
  //     if (rep.statusCode == 200 || rep.statusCode == 201) {
  //       isLoading = false;
  //       var decodeData = rep.data;
  //       var responseData = GetUserTotalModel.fromJson(decodeData);
  //       var data = responseData.usercount;
  //       print(data);
  //
  //       notifyListeners();
  //     }
  //
  //     notifyListeners();
  //   } catch (e, s) {
  //     throw Exception('something went wrong: $e');
  //   }
  // }
  //choose to use hhtp here!!
  Future<GetUserTotalModel?> userData(context) async {
    final storage = await SharedPreferences.getInstance();
    token = await storage.getString('token');
    notifyListeners();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      "Authorization": "Bearer $token ",
    };
    try {
      var url = Uri.parse(
          'https://halat-mobile-bank-app.herokuapp.com/api/v1/countUsers');
      var response = await http.get(url, headers: requestHeaders);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodeData = jsonDecode(response.body);
        var responseModel = GetUserTotalModel.fromJson(decodeData);
        total = responseModel.usercount;
        print(total);

        notifyListeners();

        print("Response:${response.body}");
        return responseModel;
      }
    } catch (e, s) {
      print('Error $e');
    }
  }
}
