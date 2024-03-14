import 'package:capygotchi/core/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Utils {
  static showAlertOK({required BuildContext context, required String title, required String text, required String okBtnText}) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(okBtnText))
          ],
        );
      }
    );
  }
  static showAlertPremium({required BuildContext context, required String title, required String text, required String OKBtnText}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    context.read<User>().refreshUser();
                    context.read<User>().notifyListeners();
                    Navigator.pop(context);
                  },
                  child: Text(OKBtnText))
              ],
              );
            }
    );
  }
}