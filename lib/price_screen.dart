import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:cupertino_icons/cupertino_icons.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData cd = CoinData();
  List<int> values = [0, 0, 0];
  String first = "USD";

  List<Widget> getcards() {
    List<Widget> ret = [];
    int h = 0;
    for (String i in cryptoList) {
      ret.add(
        Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '$i = ${values[h]} $first',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
      h++;
      ;
    }
    return ret;
  }

  Widget andpicker() {
    List<DropdownMenuItem> ret = [];
    for (String i in currenciesList) {
      var g = DropdownMenuItem(
        child: Text(i),
        value: i,
      );
      ret.add(g);
    }
    return DropdownButton(
        value: first,
        onChanged: (val) async {
          getData(val);
        },
        items: ret);
  }

  Widget getpicker() {
    if (true) {
      return andpicker();
    } else {
      return iospicker();
    }
  }

  Widget iospicker() {
    List<Text> ret = [];
    for (String i in currenciesList) {
      ret.add(Text(i));
    }
    return CupertinoPicker(
      onSelectedItemChanged: (val) {
        print(val);
      },
      itemExtent: 40,
      children: ret,
    );
  }

  void getData(String val) async {
    List<double> price = await cd.call(val);

    print(price);
    setState(() {
      values[0] = price[0].toInt();
      values[1] = price[1].toInt();
      values[2] = price[2].toInt();

      first = val;
    });
  }

  @override
  void initState() {
    super.initState();
    getData("INR");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: getcards(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getpicker(),
          )
        ],
      ),
    );
  }
}
