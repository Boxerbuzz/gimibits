/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimibits/exports.dart';

class PairSelector extends StatefulWidget {
  final String label;
  final MarketPair selected;
  final String type;
  PairSelector({this.label, this.selected, this.type, this.onChanged});
  final ValueChanged<MarketPair> onChanged;

  @override
  _PairSelectorState createState() => _PairSelectorState();
}

class _PairSelectorState extends State<PairSelector> {
  MarketPair _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption =
        widget.selected ?? MarketPair(name: 'BTC/USD', urlSymbol: 'btcusd');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: 120.0,
      decoration: BoxDecoration(
        color: CupertinoDynamicColor.withBrightness(
          color: Theme.of(context).colorScheme.onBackground,
          darkColor: Theme.of(context).colorScheme.background,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Row(
          children: [
            Text(
              _selectedOption.name,
              style: Theme.of(context).textTheme.headline5,
            ),
            Expanded(child: Container()),
            Text('▼', style: GoogleFonts.baloo(fontSize: 27)),
            SizedBox(width: 10.0),
          ],
        ),
      ),
    ).ripple(onTap: () => _showOptions());
  }

  _showOptions() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PairSelectorOptions(
          title: widget.label,
          selectedOption: _selectedOption,
          type: widget.type,
        ),
      ),
    ).then((value) {
      _selectedOption = value;
      widget.onChanged(value);
    });
  }
}

class PairSelectorOptions extends StatefulWidget {
  final String title;
  final MarketPair selectedOption;
  final String type;

  const PairSelectorOptions({
    Key key,
    @required this.title,
    this.selectedOption,
    this.type,
  }) : super(key: key);
  @override
  _PairSelectorOptionsState createState() => _PairSelectorOptionsState();
}

class _PairSelectorOptionsState extends State<PairSelectorOptions> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MarketPair _selectedOption;
  List<MarketPair> options = new List();
  bool isLoading = false;

  @override
  void initState() {
    _fetchPairs();
    super.initState();
    if(options.length > 0) _selectedOption = widget.selectedOption;
  }

  _fetchPairs() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      final _store = Provider.of<MainProvider>(context, listen: false);
      if (!isLoading) {
        setState(() => isLoading = true);
        print('here');
        options = await _store.fetchOnlyPairs();
        if(options.length == 0) _selectedOption = options[0];
        setState(() => isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _store = Provider.of<MainProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        title: Center(child: Text(widget.title, style: Styles.optionsTitle)),
        actions: <Widget>[
          FlatButton(
            child: Text('Done', style: Styles.textButton),
            onPressed: () => _sendSelectedOption(),
          )
        ],
        leading: SizedBox.shrink(),
      ),
      backgroundColor: Color(0xfff4f4f4),
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  for (var option in _store.exchangePair) _buildOption(option)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(MarketPair option) {
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
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  option.name,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 10.0),
                Text(
                  option.description,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            Expanded(child: Container()),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: 15.0,
                width: 15.0,
                decoration: BoxDecoration(
                  color: _selectedOption == option
                      ? Colors.red
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Container(
                    height: 10.0,
                    width: 10.0,
                    decoration: BoxDecoration(
                      color: R.C.kBackgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Select one of the options')));
  }

  void _selectOption(MarketPair option) {
    setState(() {
      _selectedOption = option;
    });
  }
}
*/
