import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/switch_controllers.dart';
import '../../controllers/variable_controllers.dart';
import '../../modals/variable_modals.dart';

class AddComponent extends StatefulWidget {
  const AddComponent({Key? key}) : super(key: key);

  @override
  State<AddComponent> createState() => _AddComponentState();
}

class _AddComponentState extends State<AddComponent> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime initialDate = DateTime.now();
  DateTime initialTime = DateTime.now();
  TimeOfDay initialTime1 = TimeOfDay.now();

  DateTime? pickedDate;
  DateTime? pickedTime;
  late String periodName;

  @override
  void initState() {
    super.initState();
    initialTime = DateTime.now();

    if (initialTime.hour >= 12) {
      periodName = "pm";
    } else {
      periodName = "am";
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Provider.of<AppProvider>(context).appModal.switchVal == false)
        ? Padding(
        padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  (Provider.of<AddChatProvider>(context).Variable.img != null)
                  ? GestureDetector(
                    onTap: () {
                      Provider.of<AddChatProvider>(context,listen: false).pickImage();
                    },
                    child: CircleAvatar(
                      radius: 80,
                      foregroundImage: FileImage(Provider.of<AddChatProvider>(context).Variable.img!),
                      child: const Icon(
                        Icons.add_a_photo_outlined,
                        size: 40,
                      ),
                    ),
                  ) : GestureDetector(
                    onTap: () {
                      Provider.of<AddChatProvider>(context,listen: false).pickImage();
                    },
                    child: const CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.greenAccent,
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: Variables.name,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter Your full name";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  hintText: "Full Name",
                  hintStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: Variables.phone,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter Phone Number";
                  } else if (val.length != 10) {
                    return "Not Valid Number";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.call),
                  hintText: "Phone Number",
                  hintStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: Variables.chat,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter Message";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.chat),
                  hintText: "Chat Conversation",
                  hintStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
          const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: initialDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2099),
                        );

                        setState(() {
                          if (date != pickedDate && date != null) {
                            pickedDate = date;
                          }
                        });
                      },
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      size: 30,
                    ),
                  ),
                  (pickedDate != null)
                  ? Text(
                    "${pickedDate?.day} - ${pickedDate?.month} - ${pickedDate?.year}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ) : const Text(
                    "Pick date",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: initialTime1,
                        );

                        setState(() {
                          if (pickedTime != pickedDate &&
                              pickedTime != initialTime) {
                            initialTime1 = pickedTime!;
                          }
                        });
                      },
                    icon: const Icon(
                      Icons.watch_later_outlined,
                      size: 30,
                    ),
                  ),
                  (initialTime != null)
                      ? (initialTime1.periodOffset == 0)
                      ? Text("${initialTime.hour} : ${initialTime.minute}  ${initialTime1.period.name}")
                      : Text(
                    "${initialTime.hour - 12} ${initialTime.minute} ${initialTime1.period.name}",
                    style: const TextStyle(
                      fontSize: 16
                    ),
                  )
                      : const Text("Pick Time",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      Provider.of<AddChatProvider>(context, listen: false).Variable.img != null) {
                    Provider.of<AddChatProvider>(context, listen: false).saveChat();
                  }
                },
                child: const Text("SAVE"),
              )
            ],
          ),
        )
      ),
    )
        :Padding(padding: const EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  (Provider.of<AddChatProvider>(context).Variable.img != null)
                ? GestureDetector(
                    onTap: () {
                      Provider.of<AddChatProvider>(context,listen: false).pickImage();
                    },
                    child: CircleAvatar(
                      radius: 80,
                      foregroundImage: FileImage(Provider.of<AddChatProvider>(context).Variable.img!),
                      child: const Icon(
                        CupertinoIcons.photo_camera,
                        size: 40,
                      ),
                    ),
                  ) :GestureDetector(
                    onTap: () {
                      Provider.of<AddChatProvider>(context, listen: false).pickImage();
                    },
                    child: const CircleAvatar(
                      radius: 80,
                      child: Icon(
                        CupertinoIcons.photo_camera,
                        size: 40,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              CupertinoTextFormFieldRow(
                textInputAction: TextInputAction.next,
                controller: Variables.name,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter Full Name";
                  } else {
                    return null;
                  }
                },
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                ),
                placeholder: "Full Name",
                prefix: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    CupertinoIcons.person,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CupertinoTextFormFieldRow(
                textInputAction: TextInputAction.next,
                controller: Variables.phone,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter Phone Number";
                  } else if (val.length != 10) {
                    return "Not Valid Number";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                ),
                placeholder: "Phone Number",
                prefix: const Padding(
                  padding:  EdgeInsets.all(5),
                  child: Icon(
                    CupertinoIcons.phone,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CupertinoTextFormFieldRow(
                controller: Variables.chat,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter Any Message";
                  } else {
                    return null;
                  }
                },
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                ),
                placeholder: "Chat Conversation",
                prefix: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    CupertinoIcons.chat_bubble_text,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) => Container(
                        height: 340,
                        color: Colors.white,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          minimumYear: 2000,
                          maximumYear: 2099,
                          onDateTimeChanged: (val) {
                            setState(() {
                              initialDate = val;
                            });
                          },
                          initialDateTime: initialDate,
                        ))
                  );
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Icon(
                       CupertinoIcons.calendar,
                        size: 30,
                      ),
                    ),
                    SizedBox(width: 18),
                    (pickedDate != null)
                    ? Text("${initialDate.day} - ${initialDate.month} - ${initialDate.year}"
                    )
                        : Text("Pick Date",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => Container(
                      height: 340,
                      color: Colors.white,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        maximumYear: 2099,
                        minimumYear: 2000,
                        onDateTimeChanged: (val) {
                          setState(() {
                            initialTime = val;
                          });
                        },
                        use24hFormat: false,
                        initialDateTime: initialTime,
                      ),
                    )
                  );
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Icon(CupertinoIcons.time,
                        size: 30,
                      ),
                    ),
                    SizedBox(width: 18),
                    (pickedTime != null) 
                      ? (periodName == 'am')
                        ? Text("${initialTime.hour} : ${initialTime.minute}  $periodName",
                    )
                        :(initialTime.hour > 12)
                        ? Text("${initialTime.hour - 12} : ${initialTime.minute}  $periodName")
                        :Text("${initialTime.hour} :${initialTime.minute}  $periodName")
                        :Text("Pick Time",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey
                    ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              CupertinoButton(
                color: Colors.blue,
                  child: Text("SAVE"),
                onPressed: () { },
              )
            ],
          ),
        ),
      ),
    );
  }
}
