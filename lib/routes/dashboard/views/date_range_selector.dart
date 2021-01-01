import 'package:flutter/material.dart';
import '../../../exports.dart';

class DateRangeSelector extends StatefulWidget {
  final Map<String, List<String>> options;
  final Function onChange;
  final String mainValue;
  const DateRangeSelector(
    this.options,
    this.onChange, {
    Key key,
    this.mainValue,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DateRangeSelectorState();
}

class _DateRangeSelectorState extends State<DateRangeSelector> {
  String mainValue;
  String subValue;
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    mainValue =
        widget.mainValue == null ? widget.options.keys.first : widget.mainValue;
    subValue = widget.options[mainValue][0];
    controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: createDropWidget(),
          ),
          Expanded(flex: 1, child: createList()),
        ],
      ),
    );
  }

  Widget createDropWidget() {
    return OutlineButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: DropdownButton<String>(
        underline: SizedBox.shrink(),
        value: mainValue,
        onChanged: (String newValue) {
          setState(() {
            mainValue = newValue;
            controller.animateTo(
              0.0,
              duration: Duration(milliseconds: 25),
              curve: ElasticInOutCurve(),
            );
            widget.onChange(mainValue, 0);
          });
        },
        style: GoogleFonts.quicksand(
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
        ),
        elevation: 2,
        items:
            widget.options.keys.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.getColor(context)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget createList() {
    if (!widget.options[mainValue].contains(subValue)) {
      subValue = widget.options[mainValue][0];
    }
    List<Widget> texts = widget.options[mainValue].map((value) {
      if (value == subValue) {
        return Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      }
      return Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
        ),
      );
    }).toList();
    return ListView.builder(
      itemBuilder: (content, index) {
        Text text = texts[index];
        return InkWell(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: text,
          ),
          onTap: () {
            this.setState(() {
              subValue = text.data;
              widget.onChange(mainValue, index);
            });
          },
        );
      },
      itemCount: widget.options[mainValue].length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      controller: controller,
    );
  }
}
