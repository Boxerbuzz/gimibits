import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gimibits/exports.dart';

class GBCards extends StatefulWidget {
  @override
  _GBCardsState createState() => _GBCardsState();
}

class _GBCardsState extends State<GBCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildTopAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 220.0,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.white,
                  border: Border.all(
                    width: 0.5,
                    color: R.C.kTextSecondaryColor,
                    style: BorderStyle.none,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Add New Card',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                      ),
                    ),
                    SvgPicture.asset(
                      R.I.icAddCard,
                      height: 50,
                      width: 50.0,
                    )
                  ],
                ),
              ).ripple(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => GBAddCard(),
                  ),
                ),
              ),
              ...cardDetails().map((c) {
                var data = Card.fromJson(c);
                return CardItem(card: data);
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopAppBar() {
    return new AppBar(
      leading: CupertinoButton(
        child: IconWidget(
          iconPath: R.I.icBack,
          padding: 0.0,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 0,
      title: Row(
        children: <Widget>[
          Text(
            'My Cards',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconWidget(
                    iconPath: R.I.icAdd,
                    color: AppTheme.getColor(context),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final Card card;
  CardItem({this.card});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Color(card.color),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(
                image: AssetImage('assets/images/${card.image}.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage('assets/images/chip.png'),
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/${card.card}.png',
                          height: 30,
                          width: 50,
                        ),
                        Text(
                          card.type.toUpperCase(),
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Text(
                  '${card.number}',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CARD HOLDER',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'TIMOTHY ONORIODE OFIE',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EXPIRY',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '05/29',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Card {
  final String bank;
  final String card;
  final String type;
  final String number;
  final int color;
  final String image;
  final String balance;
  final List<dynamic> transact;

  Card(
      {this.bank,
      this.card,
      this.type,
      this.number,
      this.color,
      this.image,
      this.balance,
      this.transact});

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      bank: json['bank'],
      card: json['class'],
      type: json['type'],
      color: json['color'],
      image: json['image'],
      balance: json['balance'],
      number: json['number'],
      transact: json['transaction'],
    );
  }
}

class Transaction {}
