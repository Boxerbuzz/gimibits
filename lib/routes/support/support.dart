import 'package:flutter/material.dart';

import '../../exports.dart';

class GBSupport extends StatelessWidget with FormMixin {
  static Screen gmSupport = Screen(
    title: 'Support',
    contentBuilder: (context) => GBSupport(),
  );

  final ValueNotifier<String> valueNotifier = ValueNotifier('');

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 30.0),
            SvgPicture.asset(
              Theme.of(context).brightness == Brightness.light
                  ? 'assets/images/support_light.svg'
                  : 'assets/images/support_dark.svg',
              height: 300.0,
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
                    'Contact\nOur Support',
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
            TextInput(
              onValidate: onItemValidate,
              isRequired: true,
              label: 'Subject',
              helper: 'Subject',
              type: InputType.text,
              initialValue: '',
              isActive: true,
              onChange: onItemChange,
              key: ValueKey('subject'),
              valueNotifier: valueNotifier,
            ),
            TextInput(
              onValidate: onItemValidate,
              isRequired: true,
              label: 'Leave us a note',
              helper: 'Leave us a note',
              type: InputType.text,
              initialValue: '',
              isActive: true,
              onChange: onItemChange,
              key: ValueKey('note'),
              maxLines: 5,
              valueNotifier: valueNotifier,
            ),
            CommonButton(
              title: 'Submit',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onItemChange(String name, String value) {
    // TODO: implement onItemChange
  }

  @override
  void onItemValidate(String name, bool isValid, {String value}) {
    // TODO: implement onItemValidate
  }
}
