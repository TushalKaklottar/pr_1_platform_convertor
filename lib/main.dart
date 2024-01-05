import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr_1/utils/theme.dart';
import 'package:pr_1/views/screens/cupertino_app.dart';
import 'package:pr_1/views/screens/material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/profile_controllers.dart';
import 'controllers/switch_controllers.dart';
import 'controllers/theme_controllers.dart';
import 'controllers/variable_controllers.dart';
import 'modals/profile_modals.dart';
import 'modals/switch_modals.dart';
import 'modals/theme_modals.dart';
import 'modals/variable_modals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool SwitchVal = prefs.getBool('SwitchVal') ?? false;
  bool isdark = prefs.getBool('isdark') ?? false;
  bool profileSwitch = prefs.getBool('profileSwitch') ?? false;

  String userImage = prefs.getString('userImage') ?? '';
  String userName = prefs.getString('userName') ?? '';
  String userBio = prefs.getString('userBio') ?? '';

  List<String> image = prefs.getStringList('image') ?? [];
  List<String> fullName = prefs.getStringList('fullName') ?? [];
  List<String> phoneNumber = prefs.getStringList('phoneNumber') ?? [];
  List<String> chatConversation = prefs.getStringList('chatConversation') ?? [];


  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => AppProvider(
                  appModal: AppModal(
                    switchVal: SwitchVal,
                  ),
              ),
          ),
          ChangeNotifierProvider(
              create: (context) => themeProvider(
                thememodel: themeModel(
                  isDark: isdark,
                ),
              ),
          ),
          ChangeNotifierProvider(
            create: (context) => ProfileProvider(
              profileModal: ProfileModal(
                profileVal: profileSwitch,
                userImage: File(userImage),
                userName: TextEditingController(text: userName),
                userBio: TextEditingController(text: userBio),
              ),
            ),
          ),
          ChangeNotifierProvider(
              create: (context) => AddChatProvider(
                  Variable: AddChatModel(
                    fullName: fullName,
                    phoneNumber: phoneNumber,
                    chatConversation: chatConversation,
                    image: image,
                  ),
              ),
          ),
    ],
      builder: (context,_) {
        return (Provider.of<AppProvider>(context).appModal.switchVal==false)
            ? MaterialApp(
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: (Provider.of<themeProvider>(context).thememodel.isDark == false)
          ? ThemeMode.light
              : ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const materialApp(),
          },
        ):  CupertinoApp(
          theme: CupertinoThemeData(
            brightness: (Provider.of<themeProvider>(context).thememodel.isDark == false)
                ? Brightness.light
                : Brightness.dark,
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const cupertinoApp(),
          },
        );
      },
    )
  );
}