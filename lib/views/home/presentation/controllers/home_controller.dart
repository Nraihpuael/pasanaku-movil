import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pasanaku/models/models.dart';
import 'package:pasanaku/views/shared/widgets/shared_pref.dart';

class HomeController{
  BuildContext? context;
  
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;
  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
  }

  void logout(){
    _sharedPref.logout(context!);
  }


  void openDrawer(){
    key.currentState!.openDrawer();
  }
}