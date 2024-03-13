import 'package:flutter/material.dart';

class Utils {
  static showAlertOK({required BuildContext context, required String title, required String text, required String okBtnText}) {
    showDialog(
      context: context,
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
  static showAlertPremium({required BuildContext context, required String title, required String text, required String yesBtnText, required String noBtnText}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(noBtnText)
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(yesBtnText))
              ],
              );
            }
    );
  }
}