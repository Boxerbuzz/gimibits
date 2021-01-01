import 'package:flutter/cupertino.dart';

import '../exports.dart';

enum TradeType {
  MarketOrder,
  StopOrder,
  LimitOrder,
}

class SendProvider with ChangeNotifier {
  CryptoAsset _selectedAsset = CryptoAsset.assets[0];
  CryptoAsset get selectedAsset => _selectedAsset;
  TradeType type = TradeType.MarketOrder;
  String sType = 'market';

  updateType(val) {
    if (val == 'market') {
      sType = val;
      updateTypeState(TradeType.MarketOrder);
    }
    if (val == 'stop') {
      sType = val;
      updateTypeState(TradeType.StopOrder);
    }
    if (val == 'limit') {
      sType = val;
      updateTypeState(TradeType.LimitOrder);
    }
  }

  updateTypeState(val) {
    type = val;
    notifyListeners();
  }

  updateSelectWallet(asset) {
    _selectedAsset = asset;
    notifyListeners();
  }
}
