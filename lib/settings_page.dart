import 'package:flutter/cupertino.dart';

class CupertinoSettingsPage extends StatefulWidget {
  const CupertinoSettingsPage({Key? key}) : super(key: key);

  @override
  CupertinoSettingsPageState createState() => CupertinoSettingsPageState();
}

class CupertinoSettingsPageState extends State<CupertinoSettingsPage> {
  DateTime date = DateTime(2022, 4, 1);
  bool chatBackup = true;

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => SizedBox(
        height: 300,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 100,
            ),
            CupertinoFormSection(
              header: const Text('Account Details'),
              children: [
                CupertinoFormRow(
                  prefix: const Text('Name'),
                  child: CupertinoTextFormFieldRow(
                    placeholder: "Username",
                  ),
                ),
                const CupertinoFormRow(
                  prefix: Text("Email"),
                  child: Text('afiv@gmail.com'),
                ),
                CupertinoFormRow(
                  prefix: const Text('Chat Backup'),
                  child: CupertinoSwitch(
                    value: chatBackup,
                    onChanged: (value) {
                      setState(() {
                        chatBackup = !chatBackup;
                      });
                    },
                  ),
                ),
              ],
            ),
            Center(
              child: CupertinoButton(
                onPressed: () {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) => CupertinoActionSheet(
                      title: const Text('Set Wallpaper Theme'),
                      actions: <CupertinoActionSheetAction>[
                        CupertinoActionSheetAction(
                          child: const Text('Dark'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('Light'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  );
                },
                child: const Text('Chat Wallpaper'),
              ),
            ),
            Center(
              child: CupertinoButton(
                onPressed: () {
                  showCupertinoDialog<void>(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: const Text('Delete chat'),
                      content: const Text('Proceed with deleting chat?'),
                      actions: <CupertinoDialogAction>[
                        CupertinoDialogAction(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          onPressed: () {
                            // Do something destructive.
                          },
                          child: const Text('Yes'),
                        )
                      ],
                    ),
                  );
                },
                child: const Text('Delete all chat'),
              ),
            ),
            Center(
              child: CupertinoButton(
                // Display a CupertinoDatePicker in date picker mode.
                onPressed: () => _showDialog(
                  CupertinoDatePicker(
                    backgroundColor: CupertinoColors.white,
                    initialDateTime: date,
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    // This is called when the user changes the date.
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() => date = newDate);
                    },
                  ),
                ),
                // In this example, the date value is formatted manually. You can use intl package
                // to format the value based on user's locale settings.
                child: Text(
                  'Date: ${date.month}-${date.day}-${date.year}',
                  style: const TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
            ),
            Center(
              child: CupertinoButton.filled(
                onPressed: () {},
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
