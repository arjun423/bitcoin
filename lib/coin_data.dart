import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future call(String val) async {
    try {
      List<double> ret = [0, 0, 0];
      print("y");
      http.Response json = await http.get(Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$val?apikey=92D0CF3C-D96C-448D-ADDD-BDA189A18EE7'));
      for (Map i in jsonDecode(json.body)['rates']) {
        if (i["asset_id_quote"] == "BTC") {
          ret[0] = 1.0 / i["rate"];
        }
        if (i["asset_id_quote"] == "ETH") {
          ret[1] = 1.0 / i["rate"];
        }
        if (i["asset_id_quote"] == "LTC") {
          ret[2] = 1.0 / i["rate"];
        }
      }

      return ret;
    } catch (e) {
      print(e);
    }
    return 0;
  }
}
//
