import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:pasanaku/models/models.dart';
import 'package:pasanaku/providers/user_provider.dart';
import 'package:pasanaku/views/shared/widgets/my_snackbar.dart';
import 'package:pasanaku/views/shared/widgets/shared_pref.dart';

class LoginController{

  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserProvider userProvider = UserProvider();
  SharedPref _sharedPref = SharedPref(); 

  Future? init(BuildContext context) async{
    this.context = context;
    await userProvider.init(context);
    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    if (user.email != null){
      context.go('/home');

    }
  }

/**
 * email, name, lastname, phone, password
 * 
 */

  /*void goToRegisterPage(){
    Navigator.pushNamed(context!, 'register');
  }*/

  void login(BuildContext con) async{
    String email = emailController.text;
    String password = passwordController.text;
    ResponseApi? responseApi = await userProvider.login(email, password);
    MySnackbar.show(context!, responseApi.toString());
    print('email: $email, password: $password');
    if (responseApi?.data != null){
      User user = User.fromJson(responseApi!.data);
      _sharedPref.save('user', user.toJsonReg());
      // ignore: use_build_context_synchronously
      con.go('/home');
    } else {
      MySnackbar.show(context!, "correo no existe, o clave erronea");
    }
  }

}