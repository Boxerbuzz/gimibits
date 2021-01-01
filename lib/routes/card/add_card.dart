import 'package:flutter/material.dart';

import '../../exports.dart';

class GBAddCard extends StatefulWidget {
  @override
  _GBAddCardState createState() => _GBAddCardState();
}

class _GBAddCardState extends State<GBAddCard> with FormMixin {
  final _formKey = GlobalKey<FormState>();
  CreditCardNetwork _cardNetwork;

  SharedFormState sharedState;
  Map<String, String> get values => sharedState.valuesByName;

  @override
  void initState() {
    sharedState = Provider.of<SharedFormState>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormPage(
      formKey: _formKey,
      pageSizeProportion: 1.0,
      children: [
        SizedBox(height: 30.0),
        SvgPicture.asset(
          Theme.of(context).brightness == Brightness.light
              ? 'assets/images/card_dark.svg'
              : 'assets/images/card_light.svg',
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
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: 20.0),
            Text(
              'Add\nDebit Card',
              style: GoogleFonts.barlow(
                fontSize: 30.0,
                fontWeight: FontWeight.w700,
                height: 0.9,
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
        SizedBox(height: 20.0),
        CreditCardInfoInput(
          key: ValueKey(FormKeys.ccNumber),
          label: 'Card Number',
          helper: '4111 2222 3333 4440',
          cardNetwork: _cardNetwork,
          onValidate: onItemValidate,
          onChange: _handleItemChange,
          inputType: CreditCardInputType.number,
        ),
        TextInput(
          key: ValueKey(FormKeys.ccName),
          label: 'Card Name',
          helper: 'Cardholder Name',
          onValidate: onItemValidate,
          type: InputType.text,
          onChange: onItemChange,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: CreditCardInfoInput(
                key: ValueKey(FormKeys.ccExpDate),
                label: 'Expiration',
                helper: 'MM/YY',
                onValidate: onItemValidate,
                inputType: CreditCardInputType.expirationDate,
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: CreditCardInfoInput(
                key: ValueKey(FormKeys.ccCode),
                cardNetwork: _cardNetwork,
                label: 'Security Code',
                helper: '000',
                onValidate: onItemValidate,
                inputType: CreditCardInputType.securityCode,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        CommonButton(
          title: 'Add Card',
          isLoading: false,
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            print('here');
          },
        ),
      ],
    );
  }

  @override
  void onItemValidate(String key, bool isValid, {String value}) {
    validInputsMap[key] = isValid;
    values[key] = value;

    Future.delayed(
      Duration(milliseconds: 500),
      () {
        if (this.mounted)
          setState(() {
            /*formCompletion = super.countValidItems() / validInputsMap.length;
            if (formCompletion == 1) isFormErrorVisible = false;*/
          });
      },
    );
  }

  void _handleItemChange(CreditCardNetwork cardNetwork) {
    setState(() => _cardNetwork = cardNetwork);
  }

  @override
  void onItemChange(String name, String value) => values[name] = value;
}
