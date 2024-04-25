import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:pasanaku/models/models.dart';
import 'package:pasanaku/providers/user_provider.dart';
import 'package:pasanaku/views/shared/widgets/my_snackbar.dart';
import 'package:pasanaku/views/shared/widgets/shared_pref.dart';

import '../../../../models/invitacion.dart';
import '../../../../providers/invitacion_provider.dart';

class LoginController{

  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;
  InvitacionProvider _invitacionProvider = InvitacionProvider();
  List<Invitacion> invitaciones = [];

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserProvider userProvider = UserProvider();
  SharedPref _sharedPref = SharedPref(); 

  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    await userProvider.init(context);
    user = User.fromJson(await _sharedPref.read('user') ?? {});
    getInvitaciones(user?.id);    
    if(invitaciones.length > 0){
    } else{
      if (user!.email != null){
          context.go('/home');
      //}
      }
    }
  }

  void getInvitaciones(int? id) async{
    print("id de invitado: $id");
    invitaciones = (await _invitacionProvider.invitaciones(id))!;
    print(invitaciones);
    invitaciones.length;
    refresh!();
  }
  
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