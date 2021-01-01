import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:gimibits/exports.dart';
import 'package:intl/intl.dart';

class MainProvider extends ChangeNotifier {
  String _apiKey = '5bbf8851a59d8108d26e635b18522038';
  String _base = 'https://api.nomics.com/v1';
  String bBase = 'https://api.binance.com';

  bool _load = false;
  bool get load => _load;

  var header = {
    'Content-Type': 'application/json',
    'X-MBX-APIKEY':
        '98MHEtildoUlAHyQKyMC4pOStZk9AOzs0dOcOCV0x0RK4X39p9lMaabavpcUkKya'
  };

  List<Market> _topMarketLst = [];
  List<Market> get topMarketLst => _topMarketLst;

  List<TopPair> _topPairs = [];
  List<TopPair> get topPairs => _topPairs;

  List<PairInfo> _pairs = [];
  List<PairInfo> get pairs => _pairs;

  List<String> _dates = [];
  List<String> get dates => _dates;

  List<double> _prices = [];
  List<double> get prices => _prices;

  isLoading(bool val) {
    _load = val;
    notifyListeners();
  }

  ///Fetches the list of get tickers for crypto list
  Future<List<Market>> fetchNomicsList() async {
    String id =
        'BTC,ETH,LTC,XPR,DASH,ETC,BCH,XMR,XLM,ZEC,EOS,TRX,BAT,ALGO,USDT,IOT,NEO,OMG,ZIL,ZRK';
    String interval = 'interval=1h,1d,7d,30d';
    String currency = 'convert=USD';
    try {
      String url =
          '$_base/currencies/ticker?key=$_apiKey&ids=$id&$interval&$currency';
      var headers = {'Content-Type': 'application/json'};
      var source = await Helpers.httpGetRetry(url, headers);
      List lstData = jsonDecode(source.body);
      if (source.statusCode == 200) {
        return _topMarketLst = lstData.map<Market>((e) {
          var data = Market.fromJson(e);
          return data;
        }).toList();
      } else {
        return _topMarketLst ?? [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  ///Fetches a few list of crypto
  Future<List<TopPair>> fetchTopPairs() async {
    String id = 'BTC,ETH,LTC,XPR,DASH,ETC,BCH,XMR';
    String interval = 'interval=1h';
    String currency = 'convert=USD';
    try {
      String url =
          '$_base/currencies/ticker?key=$_apiKey&ids=$id&$interval&$currency';
      var headers = {'Content-Type': 'application/json'};
      var source = await Helpers.httpGetRetry(url, headers);
      List lstData = jsonDecode(source.body);
      if (source.statusCode == 200) {
        return _topPairs = lstData.map<TopPair>((e) {
          var data = TopPair.fromJson(e);
          return data;
        }).toList();
      } else {
        return _topPairs ?? [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  ///Fetches mini charts of single crypto
  Future<List<double>> fetchNomicsChart(String asset) async {
    try {
      DateFormat df = DateFormat("yyyy-MM-dd");
      String dd =
          '${df.format(DateTime.now().subtract(Duration(days: 365)))}T00%3A00%3A00Z';
      String con = 'convert=USD';
      String url =
          '$_base/currencies/sparkline?key=$_apiKey&ids=$asset&start=$dd&$con';
      var headers = {'Content-Type': 'application/json'};
      var source = await Helpers.httpGetRetry(url, headers);
      var data = jsonDecode(source.body);
      _prices = data[0]['prices'].map<double>((e) {
        return double.parse(e);
      }).toList();
      _dates = data[0]['timestamps'].map<String>((e) {
        return '$e';
      }).toList();
      return _prices ?? [];
    } catch (e) {
      print('Error :: $e');
      return [];
    }
  }

  ///Fetch news about certain topic or coin
  Future<News> fetchNews(String pairName) async {
    String url =
        'https://newsapi.org/v2/everything?q=cryptocurrencies&apiKey=dc47f2d8143a4a24b6935f7ea7413c63';
    News data;
    var header = {'Content-Type': 'application/json'};
    try {
      var res = await Helpers.httpGetRetry(url, header);
      if (res.statusCode == 200) {
        data = News.fromJson(jsonDecode(res.body));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future fetchExchangeList() async{
    String url = '$bBase/api/v3/exchangeInfo';
    try{
      var src = await Helpers.httpGetRetry(url, header);
      if(src.statusCode == 200 && src.body.isNotEmpty){
        Map<String, dynamic> res = jsonDecode(src.body);
        List symbols = res['symbols'];
        for(var symbol in symbols){
          Exchange data = Exchange.fromJson(symbol);
          var tick = await fetchPairTicker(data.symbol);
          //print(tick);
          _pairs.add(PairInfo(exchange: data, pair: tick));
        }
        return _pairs;
      }else{
        print(src.body);
      }
    }catch(e){
      print(e);
    }
  }

  Future<Pair> fetchPairTicker(String pair) async{
    String url = '$bBase/api/v3/ticker/24hr?symbol=$pair';
    try{
      var src = await Helpers.httpGetRetry(url, header);
      if(src.statusCode == 200 && src.body.isNotEmpty){
        var res = jsonDecode(src.body);
        return Pair.fromJson(res);
      }else{
        //print(src.body);
        return null;
      }
    }catch(e){
      print(e);
      return null;
    }
  }
}
