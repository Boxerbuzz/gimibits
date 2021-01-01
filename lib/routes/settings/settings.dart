import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../exports.dart';

class GBSettings extends StatefulWidget {
  static Screen gmSettings = Screen(
    title: 'Settings',
    contentBuilder: (context) => GBSettings(),
  );

  @override
  _GBSettingsState createState() => _GBSettingsState();
}

class _GBSettingsState extends State<GBSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          children: [
            SizedBox(height: 30.0),
            SvgPicture.asset(
              Theme.of(context).brightness == Brightness.light
                  ? 'assets/images/setting-dark.svg'
                  : 'assets/images/setting_light.svg',
              height: 300,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonIconButton(
                    icon: IconWidget(
                      iconPath: R.I.icBack,
                      padding: 2.0,
                    ),
                    btnColor: Theme.of(context).colorScheme.onBackground,
                    onTap: ()=> Navigator.of(context).pop(),
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    'User\nSettings',
                    style: GoogleFonts.barlow(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      height: 0.9,
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            SettingItem(
              icon: R.I.icUser,
              title: 'KYC',
              subTitle: 'Complete your KYC',
            ),
            SettingItem(
              icon: R.I.icBank,
              title: 'Bank',
              subTitle: 'Bank related settings',
            ),
            SettingItem(
              icon: R.I.icNotification,
              title: 'Notification',
              subTitle: 'Change your notification settings',
            ),
            SettingItem(
              icon: R.I.icLock,
              title: 'Security',
              subTitle: 'Secure your account',
            ),
            SettingItem(
              icon: R.I.icExclamation,
              title: 'About',
              subTitle: 'About Crypticon',
            ),
          ],
        ),
      ),
    );
  }
}
