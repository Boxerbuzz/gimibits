import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../exports.dart';

class RequestAssets extends StatelessWidget with FormMixin {
  @override
  Widget build(BuildContext context) {
    final _store = Provider.of<SendProvider>(context);
    ValueNotifier<String> amount;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SvgPicture.asset(
                Theme.of(context).brightness == Brightness.light
                    ? 'assets/images/pay_dark.svg'
                    : 'assets/images/pay_light.svg',
                height: 300,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CommonIconButton(
                  icon: IconWidget(
                    iconPath: R.I.icBack,
                    padding: 2.0,
                  ),
                  btnColor: Theme.of(context).colorScheme.onBackground,
                  onTap: () => Navigator.of(context).pop(),
                ),
                SizedBox(width: 20.0),
                Text(
                  'Request\nCrypto Asset\'s',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    height: 0.9,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            WalletItemDropdown(
              item: _store.selectedAsset,
              onTap: () async {
                CryptoAsset asset = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WalletDropdownOptions(
                      title: 'Select Wallet',
                      selectedOption: _store.selectedAsset,
                      options: CryptoAsset.assets,
                    ),
                    fullscreenDialog: true,
                  ),
                );
                if (asset != null) {
                  _store.updateSelectWallet(asset);
                }
              },
            ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Expanded(
                  child: TextInput(
                    key: ValueKey('Amount'),
                    onValidate: onItemValidate,
                    onChange: onItemChange,
                    initialValue: '',
                    type: InputType.number,
                    isActive: true,
                    helper: 'Amount',
                    label: 'Amount',
                    isRequired: true,
                    valueNotifier: amount,
                  ),
                ),
                SizedBox(width: 10.0),
                Padding(
                  padding: EdgeInsets.only(bottom: 25.0),
                  child: Container(
                    height: 55.0,
                    width: 55.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: RotatedBox(
                        quarterTurns: 5,
                        child: IconWidget(
                          iconPath: R.I.icTransfer1,
                          padding: 8.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  color: Theme.of(context).colorScheme.onBackground,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: PrettyQr(
                      image: AssetImage(
                        'assets/images/gimibits.png',
                      ),
                      typeNumber: 6,
                      size: 200,
                      data: 'https://www.google.ru',
                      errorCorrectLevel: QrErrorCorrectLevel.H,
                      roundEdges: true,
                      elementColor: AppTheme.getColor(context),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      CupertinoButton(
                        onPressed: () {},
                        child: IconWidget(
                          iconPath: R.I.icShare,
                          padding: 4.0,
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () {},
                        child: IconWidget(
                          iconPath: R.I.icCopy,
                          padding: 4.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            CommonButton(
              onPressed: () {},
              title: 'Generate Request',
              icon: R.I.icBack,
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
