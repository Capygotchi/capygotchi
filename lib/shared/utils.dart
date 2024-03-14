import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:provider/provider.dart';

import '../core/domain/entities/user.dart';

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
  static showAlertPremium({required BuildContext context, required String title, required String text, required String okBtnText}) {
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
                    context.read<User?>()?.refreshUser();
                    Navigator.pop(context);
                  },
                  child: Text(okBtnText)
              )
            ],
          );
        }
    );
  }

  static logDebug({required dynamic message}) {
    log(message.toString(), name: 'DEBUG', level: 700);
  }

  static logError({required dynamic message}) {
    log(message.toString(), name: 'ERROR', level: 1000);
  }
}