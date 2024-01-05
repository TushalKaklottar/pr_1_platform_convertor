import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/switch_controllers.dart';
import '../Componets/add_component.dart';
import '../Componets/calls_componet.dart';
import '../Componets/chat_component.dart';
import '../Componets/settings_component.dart';

class materialApp extends StatefulWidget {
  const materialApp({Key? key}) : super(key: key);

  @override
  State<materialApp> createState() => _materialAppState();
}

class _materialAppState extends State<materialApp> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int initialIndex = 0;

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Platform Converter"),
        elevation: 0,
        actions: [
          Switch(
              value: (Provider.of<AppProvider>(context).appModal.switchVal),
              onChanged: (val) {
                Provider.of<AppProvider>(context,listen: false).changeApp();
              })
        ],
      ),
      body: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (val) {
          setState(() {
            initialIndex = val;
          });
        },
        children: const [
          AddComponent(),
          ChatComponent(),
          CallsComponent(),
          SettingsComponent(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: initialIndex,
        onTap: (val) {
          setState(() {
            initialIndex = val;
            pageController.animateToPage(
                initialIndex,
                duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
          });
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt),
            label: "ADD",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: "CHATS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: "CALLS",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "SETTINGS",
          ),
        ],
      ),
    );
  }
}
