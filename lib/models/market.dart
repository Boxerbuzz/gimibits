class Market {
  final String name;
  final String code;
  final String price;
  final String image;
  final bool isSvg;
  final Map<String, dynamic> meta;
  final List<double> chart;

  Market(
      {this.name,
      this.code,
      this.price,
      this.image,
      this.isSvg,
      this.meta,
      this.chart});

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(
      name: json['name'],
      image: json['logo_url'],
      code: json['id'],
      price: json['price'],
      isSvg: determineSvg(json['logo_url']) ?? true,
      meta: json['1h'],
    );
  }

  static bool determineSvg(String src) {
    String val = src.substring(src.length - 3);
    return val == 'svg' ? true : false;
  }

  @override
  String toString() {
    return 'Market{name: $name, code: $code, price: $price, image: $image}, isSvg: $isSvg';
  }
}

class TopPair {
  final String name;
  final double change;
  final double price;
  final double pct;

  TopPair({this.name, this.change, this.price, this.pct});

  factory TopPair.fromJson(Map<String, dynamic> json) {
    return TopPair(
      name: json['id'],
      price: double.parse(json['price']),
      change: double.parse(json['1h']['price_change_pct']),
      pct: double.parse(json['1h']['price_change']),
    );
  }
}

class Pair {
  final String symbol;
  final String priceChange;
  final String priceChangePercent;
  final String weightedAvgPrice;
  final String prevClosePrice;
  final String lastPrice;
  final String lastQty;
  final String bidPrice;
  final String askPrice;
  final String openPrice;
  final String highPrice;
  final String lowPrice;
  final String volume;
  final String quoteVolume;
  final int openTime;
  final int closeTime;
  final int count;

  Pair(
      {this.symbol,
      this.priceChange,
      this.priceChangePercent,
      this.weightedAvgPrice,
      this.prevClosePrice,
      this.lastPrice,
      this.lastQty,
      this.bidPrice,
      this.askPrice,
      this.openPrice,
      this.highPrice,
      this.lowPrice,
      this.volume,
      this.quoteVolume,
      this.openTime,
      this.closeTime,
      this.count});

  factory Pair.fromJson(Map<String, dynamic> json) {
    return Pair(
      symbol: json['symbol'],
      priceChange: json['priceChange'],
      priceChangePercent: json['priceChangePercent'],
      weightedAvgPrice: json['weightedAvgPrice'],
      prevClosePrice: json['prevClosePrice'],
      lastPrice: json['lastPrice'],
      lastQty: json['lastQty'],
      bidPrice: json['bidPrice'],
      askPrice: json['askPrice'],
      openPrice: json['openPrice'],
      highPrice: json['highPrice'],
      lowPrice: json['lowPrice'],
      volume: json['volume'],
      quoteVolume: json['quoteVolume'],
      count: json['count'],
    );
  }

  @override
  String toString() {
    return 'Pair{symbol: $symbol, priceChange: $priceChange, priceChangePercent: $priceChangePercent, weightedAvgPrice: $weightedAvgPrice, prevClosePrice: $prevClosePrice, lastPrice: $lastPrice, lastQty: $lastQty, bidPrice: $bidPrice, askPrice: $askPrice, openPrice: $openPrice, highPrice: $highPrice, lowPrice: $lowPrice, volume: $volume, quoteVolume: $quoteVolume, openTime: $openTime, closeTime: $closeTime, count: $count}';
  }
}

class Exchange {
  final String symbol;
  final String status;
  final String baseAsset;
  final int baseAssetPrecision;
  final String quoteAsset;
  final int quotePrecision;
  final int quoteAssetPrecision;

  Exchange(
      {this.symbol,
      this.status,
      this.baseAsset,
      this.baseAssetPrecision,
      this.quoteAsset,
      this.quotePrecision,
      this.quoteAssetPrecision});

  factory Exchange.fromJson(Map<String, dynamic> json) {
    return Exchange(
      symbol: json['symbol'],
      status: json['status'],
      baseAsset: json['baseAsset'],
      baseAssetPrecision: json['baseAssetPrecision'],
      quoteAsset: json['quoteAsset'],
      quotePrecision: json['quotePrecision'],
      quoteAssetPrecision: json['quoteAssetPrecision'],
    );
  }

  @override
  String toString() {
    return 'Exchange{symbol: $symbol, status: $status, baseAsset: $baseAsset, baseAssetPrecision: $baseAssetPrecision, quoteAsset: $quoteAsset, quotePrecision: $quotePrecision, quoteAssetPrecision: $quoteAssetPrecision}';
  }
}

class PairInfo {
  final Exchange exchange;
  final Pair pair;

  PairInfo({this.exchange, this.pair});
}
