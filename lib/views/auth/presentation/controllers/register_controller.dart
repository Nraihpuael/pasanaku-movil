import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pasanaku/models/response_api.dart';
import 'package:pasanaku/models/user.dart';
import 'package:pasanaku/providers/user_provider.dart';
import 'package:pasanaku/views/shared/widgets/my_snackbar.dart';
import 'package:pasanaku/views/shared/widgets/shared_pref.dart';

class RegisterController{

  BuildContext? context;
  TextEditingController emailController= TextEditingController();
  TextEditingController nameController= TextEditingController();
  TextEditingController ciController= TextEditingController();
  TextEditingController phoneController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  TextEditingController direccionController= TextEditingController();

  UserProvider userProvider = UserProvider();
  SharedPref _sharedPref = SharedPref(); 

  // ignore: body_might_complete_normally_nullable
  Future? init(BuildContext context){
    this.context = context;
    userProvider.init(context);
  }


  void register() async{
    String email = emailController.text.trim();
    String name = nameController.text;
    String phone = phoneController.text.trim();
    String ci = ciController.text;
    String password = passwordController.text.trim();
    String direccion = direccionController.text.trim();


    if (email.isEmpty || name.isEmpty || phone.isEmpty || ci.isEmpty || password.isEmpty || direccion.isEmpty){
      MySnackbar.show(context!, 'Debes ingresar todos los campos');
      return;
    }



    User user = User( 
      email: email,
      nombre: name,
      direccion: direccion,
      telefono: phone,
      password: password, 
      ci: ci
    );


    ResponseApi? responseApi = await userProvider.create(user);
    //MySnackbar.show(context!, responseApi!.message);
    print('Respuesta: ${responseApi?.toJson()}');
    if (responseApi?.error == null){
      User user = User.fromJson(responseApi?.data);
      _sharedPref.save('user', user.toJsonReg());
      // ignore: use_build_context_synchronously
      context?.go('/home');
    }

    //print('$email, $name, $phone, $lastName, $password, $confirmedPassword');
  }



}