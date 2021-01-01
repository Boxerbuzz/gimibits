class CryptoAsset {
  final String image;
  final String name;
  final String code;
  final String amount;
  final String increase;
  final String pctIncrease;
  final bool isSvg;
  final String value;
  final String address;

  CryptoAsset({
    this.image,
    this.name,
    this.code,
    this.amount,
    this.increase,
    this.pctIncrease,
    this.isSvg,
    this.value,
    this.address,
  });

  static bool determineSvg(String src) {
    String val = src.substring(src.length - 3);
    return val == 'svg' ? true : false;
  }

  static List<CryptoAsset> assets = [
    CryptoAsset(
      image: 'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/btc.svg',
      name: 'Bitcoin',
      code: 'BTC',
      amount: '0.3',
      value: '1,515,470.41',
      increase: '32000.47',
      pctIncrease: '0.002',
      isSvg: true,
      address: '3LoJFcGiBgCzy235poxmq8uZGFGSK3ZbJN',
    ),
    CryptoAsset(
      image: 'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/eth.svg',
      name: 'Ethereum',
      code: 'ETH',
      amount: '5.0',
      value: '743,706.55',
      increase: '12340.94',
      pctIncrease: '0.009',
      isSvg: true,
      address: '0x501906Ce564be7bA80Eb55A29EE31ECfaE41b6f2',
    ),
    CryptoAsset(
      image: 'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/ltc.svg',
      name: 'Litecoin',
      code: 'LTC',
      amount: '20.0',
      value: '426,082.08',
      increase: '-7000',
      pctIncrease: '-0.005',
      isSvg: true,
      address: 'MT3ACvgp53eWcBtJV7j1Hj6Xfz4hb2UDRT',
    ),
    CryptoAsset(
      image: 'https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/ALGO.png',
      name: 'Algorand',
      code: 'ALGO',
      amount: '200.0',
      value: '21,340.06',
      increase: '1237.90',
      pctIncrease: '0.09',
      isSvg: false,
      address: 'PLFHBIRGM3ZWGAMCXTREX2N537TWOMFIQXHFO2ZGQOEPZU473SYBVGVA5M'
    ),
    CryptoAsset(
        image: 'https://firebasestorage.googleapis.com/v0/b/foodmonimobile.appspot.com/o/dollars.svg?alt=media&token=45c6e73c-50ac-4d5f-8631-67ddcfc09d3e',
        name: 'US Dollar',
        code: 'USD',
        amount: '21,340.06',
        value: '21,340.06',
        increase: '0.00',
        pctIncrease: '0.00',
        isSvg: true,
        address: '2110601254'
    ),
  ];
}
