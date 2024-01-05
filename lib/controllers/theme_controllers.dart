import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/theme_modals.dart';

class themeProvider extends ChangeNotifier {
  themeModel thememodel;

  themeProvider({required this.thememodel});

  void changetheme()async{
    thememodel.isDark = !thememodel.isDark;

    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('isdark', thememodel.isDark);
  }
}