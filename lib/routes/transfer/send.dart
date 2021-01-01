import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimibits/exports.dart';

class SendAsset extends StatelessWidget with FormMixin {
  @override
  Widget build(BuildContext context) {
    final _store = Provider.of<SendProvider>(context);
    ValueNotifier<String> amount;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30.0),
            SvgPicture.asset(
              Theme.of(context).brightness == Brightness.light
                  ? 'assets/images/pay_dark.svg'
                  : 'assets/images/pay_light.svg',
              height: 300,
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
                  'Send\nCrypto Asset\'s',
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
                    key: ValueKey('address'),
                    onValidate: onItemValidate,
                    onChange: onItemChange,
                    initialValue: '',
                    type: InputType.number,
                    isActive: true,
                    helper: 'Receivers Address',
                    label: 'Receivers Address',
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
                      child: IconWidget(
                        iconPath: R.I.icScan,
                        padding: 4.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _OptionalAmount(amount: '10'),
                _OptionalAmount(amount: '40'),
                _OptionalAmount(amount: '80'),
                _OptionalAmount(amount: '100'),
              ],
            ),
            SizedBox(height: 30.0),
            CommonButton(
              onPressed: () {},
              title: 'Send',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onItemChange(String name, String value) {}

  @override
  void onItemValidate(String name, bool isValid, {String value}) {}
}

class _OptionalAmount extends StatelessWidget {
  final String amount;
  _OptionalAmount({this.amount});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: 80.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        gradient: AppTheme.primaryGradient(context),
      ),
      child: Padding(
        padding: EdgeInsets.all(1.5),
        child: Container(
          height: 25.0,
          width: 75.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Theme.of(context).colorScheme.background,
          ),
          child: Center(
            child: Text(
              '$amount%',
              style: Theme.of(context).textTheme.overline.copyWith(
                    fontSize: 14.0,
                    letterSpacing: 0.5,
                  ),
            ),
          ),
        ),
      ),
    ).ripple(onTap: () {});
  }
}
