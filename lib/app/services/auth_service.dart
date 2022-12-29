import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_souq/app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:my_souq/app/screens/auth_screen.dart';
import 'package:my_souq/app/widgets/custom_bottom_bar.dart';
import 'package:my_souq/components/declarations.dart';
import 'package:my_souq/components/error_handling.dart';
import 'package:my_souq/components/utils.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  void signUpUser(
      {required BuildContext context, required String email, required String password, required String name}) async {
    try {
      User user = User.getNewEmpty();

      http.Response res = await http.post(
          Uri.parse('$myUri01/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
          }
      );

      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Account created, Now you are login");
          }
      );
    } catch (err) {
        showSnackBar(context, err.toString());
    }
  }

  void signInUser(
      {required BuildContext context, required String email, required String password}) async {
    try {

      http.Response res = await http.post(
          Uri.parse('$myUri01/api/signin'),
          body: jsonEncode({
            'email': email,
            'password': password
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
          }
      );

      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences preferences = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await preferences.setString("my-souq-auth-token", jsonDecode(res.body)['token']);
            //showSnackBar(context, "Success you are welcome :)");
            Navigator.pushNamedAndRemoveUntil(context, BottomBar.routeName, (route) => false);
          }
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try  {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = sp.getString('my-souq-auth-token');

      if(token == null) {
           sp.setString('my-souq-auth-token', '');
      }
      
      var resToken = await http.post(
          Uri.parse('$myUri01/isValidToken'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'my-souq-auth-token': token!
          }
      );

      var response = jsonDecode(resToken.body);

      if (response == true) {
        http.Response userRes = await http.get(
            Uri.parse('$myUri01/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=utf-8',
              'my-souq-auth-token': token
            }
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch(err) {
      showSnackBar(context, err.toString());
    }
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('my-souq-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(context, AuthScreen.routName, (route) => false);
    } catch (e) {
       showSnackBar(context, e.toString());
    }
  }
}