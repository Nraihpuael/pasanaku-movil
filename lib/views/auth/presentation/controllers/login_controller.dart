import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pasanaku/models/models.dart';
import 'package:pasanaku/providers/user_provider.dart';
import 'package:pasanaku/views/shared/widgets/my_snackbar.dart';

class LoginController{

  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserProvider userProvider = UserProvider();

  Future? init(BuildContext context) async{
    this.context = context;
    await userProvider.init(context);
  }

/**
 * email, name, lastname, phone, password
 * 
 */

  /*void goToRegisterPage(){
    Navigator.pushNamed(context!, 'register');
  }*/

  void login() async{
    String email = emailController.text;
    String password = passwordController.text;
    ResponseApi? responseApi = await userProvider.login(email, password);
    MySnackbar.show(context!, responseApi.toString());
    print('email: $email, password: $password');
  }

}