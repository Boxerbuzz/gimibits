import 'package:flutter/material.dart';
import 'package:gimibits/components/inputs/styles.dart';

import '../../../exports.dart';


//Dropdown Widget
class WalletItemDropdown extends StatelessWidget {
  final CryptoAsset item;
  final onTap;
  WalletItemDropdown({this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BoxPanel(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
      child: Row(
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: item.isSvg == true
                  ? SvgPicture.network(item.image)
                  : Image.network(item.image),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  item.code,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Row(
                  children: [
                    Text(
                      item.amount,
                    ),
                    SizedBox(width: 5.0),
                    Text('='),
                    SizedBox(width: 5.0),
                    Text(
                      item.value,
                    ),
                  ],
                ),
              ],
            ),
          ),
          RotatedBox(
            quarterTurns: 1,
            child: CommonIconButton(
              icon: IconWidget(
                iconPath: R.I.icRightArrow,
                padding: 4.0,
              ),
              btnColor: Theme.of(context).colorScheme.surface,
            ),
          )
        ],
      ),
    ).ripple(onTap: onTap);
  }
}


//Option Screen
class WalletDropdownOptions extends StatefulWidget {
  final String title;
  final List<CryptoAsset> options;
  final CryptoAsset selectedOption;

  const WalletDropdownOptions(
      {Key key,
      @required this.title,
      @required this.options,
      this.selectedOption})
      : super(key: key);

  @override
  _WalletDropdownOptionsState createState() => _WalletDropdownOptionsState();
}

class _WalletDropdownOptionsState extends State<WalletDropdownOptions> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  CryptoAsset _selectedOption;

  @override
  void initState() {
    _selectedOption = widget.selectedOption ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: FullDialogAppBar(
        title: widget.title,
        action: TextButton(
          child: IconWidget(iconPath: R.I.icCheck, padding: 5.0),
          onPressed: _sendSelectedOption,
        ),
      ),
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  for (var option in widget.options) _buildOption(option)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(CryptoAsset option) {
    return GestureDetector(
      onTap: () => _selectOption(option),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: option.isSvg == true
                    ? SvgPicture.network(option.image)
                    : Image.network(option.image),
              ),
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(option.code, style: Theme.of(context).textTheme.headline4),
                Row(
                  children: [
                    Text(option.amount, style: Theme.of(context).textTheme.headline5),
                    SizedBox(width:10.0),
                    Text('= \$ ${option.value}', style: Theme.of(context).textTheme.headline5),
                  ],
                ),
              ],
            ),
            Expanded(child: Container()),
            IconWidget(
              iconPath: R.I.icCheck,
              color: _selectedOption == option
                  ? Styles.secondaryColor
                  : Colors.transparent,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _sendSelectedOption() {
    if (_selectedOption != null)
      Navigator.pop(context, _selectedOption);
    else
      _scaffoldKey.currentState
      // ignore: deprecated_member_use
          .showSnackBar(SnackBar(content: Text('Select one of the options')));
  }

  void _selectOption(CryptoAsset option) {
    setState(() {
      _selectedOption = option;
    });
  }
}
