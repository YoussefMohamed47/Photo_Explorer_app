import 'package:flutter/material.dart';

Future<void> showAlertDialog(BuildContext context, Function logoutFun) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // <-- SEE HERE
        title: const Text('Sign Out'),
        content: const Text('Are you sure want to logout?'),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              logoutFun();
            },
          ),
        ],
      );
    },
  );
}
