class History {
  final String assets;
  final String desc;
  final String date;
  final String amount;
  final String value;
  final String mode;

  History({this.assets, this.desc, this.date, this.value, this.amount, this.mode});

  static List<History> historyLst = [
    History(
      assets: 'BTC',
      amount: '0.03',
      date: '01 MAY 2020',
      desc: 'Received',
      value: '4500.78',
      mode: 'C'
    ),
    History(
      assets: 'BTC',
      amount: '0.003',
      date: '01 MAY 2020',
      desc: 'Fee',
      value: '20.00',
      mode: 'D'
    ),
    History(
      assets: 'BTC',
      amount: '0.5',
      date: '01 MAY 2020',
      desc: 'Sent',
      value: '39,900.897',
      mode: 'D',
    ),
  ];
}