import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/switch_modals.dart';

class AppProvider extends ChangeNotifier{
  AppModal appModal;

  AppProvider({required this.appModal});

  void changeApp() async {

    appModal.switchVal = !appModal.switchVal;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('SwitchVal', appModal.switchVal);

    notifyListeners();
  }
}