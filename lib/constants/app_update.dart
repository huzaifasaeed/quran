import 'package:app_version_update/app_version_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdate {
  AppUpdate._();
   static void versionCheck(context) async {
    try {
      await AppVersionUpdate.checkForUpdates(playStoreId: 'com.quran.holyquran.app')
          .then((data) async {
        print(data.storeUrl);
        print(data.storeVersion);
        if (data.canUpdate!) {
          showVersionDialog(context);
        }
      });
    } catch (e) {}
  }

  static void showVersionDialog(BuildContext context) async {
    await showCupertinoDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of the app available. Please update it now.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";

        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                btnLabelCancel,
                style: const TextStyle(color: Colors.black87),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              child: Text(
                btnLabel,
                style: const TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.pop(context);
                launchURL('https://play.google.com/store/apps/details?id=com.quran.holyquran.app'); // Replace with your URL launch logic
              },
            ),
          ],
        );
      },
    );
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}