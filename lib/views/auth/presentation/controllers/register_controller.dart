import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pasanaku/models/response_api.dart';
import 'package:pasanaku/models/user.dart';
import 'package:pasanaku/providers/user_provider.dart';
import 'package:pasanaku/views/shared/widgets/my_snackbar.dart';

class RegisterController{

  BuildContext? context;
  TextEditingController emailController= TextEditingController();
  TextEditingController nameController= TextEditingController();
  TextEditingController ciController= TextEditingController();
  TextEditingController phoneController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  TextEditingController direccionController= TextEditingController();

  UserProvider userProvider = new UserProvider();

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

    //print('$email, $name, $phone, $lastName, $password, $confirmedPassword');
  }



}