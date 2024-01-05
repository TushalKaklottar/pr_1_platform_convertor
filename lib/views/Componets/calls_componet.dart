import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/switch_controllers.dart';
import '../../controllers/variable_controllers.dart';

class CallsComponent extends StatefulWidget {
  const CallsComponent({Key? key}) : super(key: key);

  @override
  State<CallsComponent> createState() => _CallsComponentState();
}

class _CallsComponentState extends State<CallsComponent> {
  @override
  Widget build(BuildContext context) {
    return (Provider.of<AppProvider>(context).appModal.switchVal == false)
        ? (Provider.of<AddChatProvider>(context).Variable.phoneNumber.isNotEmpty)
        ? ListView.builder(
        itemBuilder: (context,i) => ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          horizontalTitleGap: 10,
          leading: CircleAvatar(
            radius: 30,
            foregroundImage: FileImage(
                File(Provider.of<AddChatProvider>(context).Variable.image[i],
                )
            ),
          ),
          title: Text(
            Provider.of<AddChatProvider>(context).Variable.fullName[i],
          ),
          subtitle: Text(
            Provider.of<AddChatProvider>(context)
                .Variable
                .chatConversation[i],
          ),
          trailing: IconButton(
            onPressed: () async {
              Uri uri = Uri.parse(
                  "tel:+91${Provider.of<AddChatProvider>(context, listen: false).Variable.phoneNumber[i]}");

              try {
                await launchUrl(uri);
              } catch (e) {
                print("Exception : $e");
              }
            },
            icon: const Icon(
              Icons.phone,
              color: Colors.green,
            ),
          ),
        ),
      itemCount: Provider.of<AddChatProvider>(context).
      Variable.fullName.length,
    ) :  const Center(
      child: Text("No Any Calls Yet..."),
    )
        :(Provider.of<AddChatProvider>(context).Variable.
    phoneNumber.isNotEmpty)

        ? CupertinoListSection(
      children: List.generate(
          Provider.of<AddChatProvider>(context).Variable.
          fullName.length,
              (i) => CupertinoListTile(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                leadingToTitle: 5,
                leadingSize: 70,
                leading: CircleAvatar(
                  radius: 30,
                  foregroundImage: FileImage(
                    File(
                      Provider.of<AddChatProvider>(context).Variable.
                      image[i],
                    ),
                  ),
                ),
                title: Text(
                  Provider.of<AddChatProvider>(context).Variable.
                  fullName[i],
                ),
                subtitle: Text(
                  Provider.of<AddChatProvider>(context).Variable.
                  chatConversation[i],
                ),
                trailing: CupertinoButton(
                  onPressed: () async {
                    Uri uri = Uri.parse(
                        "tel:+91${Provider.of<AddChatProvider>(context, listen: false).Variable.phoneNumber[i]}");
                    try {
                      await launchUrl(uri);
                    } catch (e) {
                      print("Exception : $e");
                    }
                  },
                  child: const Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                ),
              )
      )
    ) : const Center(
      heightFactor: 40,
      child: Text("No Any Calls Yet"),
    );
  }
}
