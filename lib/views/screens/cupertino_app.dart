import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../controllers/switch_controllers.dart';
import '../Componets/add_component.dart';
import '../Componets/calls_componet.dart';
import '../Componets/chat_component.dart';
import '../Componets/settings_component.dart';

class cupertinoApp extends StatefulWidget {
  const cupertinoApp({Key? key}) : super(key: key);

  @override
  State<cupertinoApp> createState() => _cupertinoAppState();
}

class _cupertinoAppState extends State<cupertinoApp> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items:  const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_add,),label: "PERSON"),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble_2,),label: "CHATS"),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.phone,),label: "CALLS"),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings,),label: "SETTINGS"),
          ],
        ),
      tabBuilder: (context, i) {
          return CupertinoTabView(
            builder: (context) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: const Text("Flutter App"),
                  trailing: CupertinoSwitch(
                    value: (Provider.of<AppProvider>(context).appModal.switchVal),
                    onChanged: (val) {
                      Provider.of<AppProvider>(context,listen: false).changeApp();
                    },
                  ),
                ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        IndexedStack(
                          index: i,
                          children: const [
                            AddComponent(),
                            CallsComponent(),
                            ChatComponent(),
                            SettingsComponent(),
                          ],
                        ),
                      ],
                    ),
                  )
              );
            },
          );
      },
    );
  }
}
