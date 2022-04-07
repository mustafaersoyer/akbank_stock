import 'package:akbank_stock/constant/colors.dart';
import 'package:akbank_stock/model/stock.dart';
import 'package:akbank_stock/service/base_service.dart';
import 'package:akbank_stock/utils/size_config.dart';
import 'package:akbank_stock/widget/stock_card.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;
  Stock stock;
  List dataList;
  getData() async {
    stock = Stock.fromJson(await BaseService().makeGetRequest(endpoint: 'demo'));
    if (stock.code == "200" || stock.code.isEmpty) {
      dataList = List(); //ToggleButton ile zaman aralığı değişimi için
      dataList.add(stock.oneDayList);
      dataList.add(stock.oneWeekList);
      dataList.add(stock.oneMounthList);
      dataList.add(stock.treeMounthList);
      dataList.add(stock.oneYearList);
      dataList.add(stock.fiveYearList);
      setState(() {
        isLoading = false;
      });
    } else {
      print(stock.code);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Akbank Stock'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
              )
            : StockCard(
                data: dataList,
                currentList: stock.oneYearList,
              ),
      ),
    );
  }
}
