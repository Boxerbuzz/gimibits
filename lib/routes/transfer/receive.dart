import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../exports.dart';

class ReceiveAssets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _store = Provider.of<SendProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
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
                    'Receive\nCrypto Asset\'s',
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
              SizedBox(height: 20.0),
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
                          child: IconWidget(iconPath: R.I.icShare, padding: 4.0,),
                        ),
                        CupertinoButton(
                          onPressed: () {},
                          child: IconWidget(iconPath: R.I.icCopy, padding: 4.0,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
