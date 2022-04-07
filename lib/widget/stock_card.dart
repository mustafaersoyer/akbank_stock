import 'package:akbank_stock/constant/colors.dart';
import 'package:akbank_stock/utils/find_max_value.dart';
import 'package:akbank_stock/utils/find_min_value.dart';
import 'package:akbank_stock/utils/size_config.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StockCard extends StatefulWidget {
  final List data;
  final List currentList;

  const StockCard({Key key, this.data, this.currentList}) : super(key: key);
  @override
  _StockCardState createState() => _StockCardState();
}

class _StockCardState extends State<StockCard> {
  List<bool> isSelected = List.generate(6, (index) => index == 1 ? true : false);
  List currentList;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.safeBlockVertical * 50,
      width: SizeConfig.safeBlockHorizontal * 85,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Şu an'),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(child: LineChart(mainData(list: currentList))),
              ),
              Center(
                child: Container(
                  height: 25,
                  child: ToggleButtons(
                    children: [Text('1G'), Text('1H'), Text('1A'), Text('3A'), Text('1Y'), Text('5Y')],
                    isSelected: isSelected,
                    onPressed: (int index) {
                      isSelected.clear(); //diğer seçenekleri false yapmak için
                      isSelected = List.generate(6, (index) => false); //diğer seçenekleri false yapmak için
                      setState(() {
                        isSelected[index] = !isSelected[index];
                      });
                      currentList = widget.data[index];
                    },
                    color: Colors.black,
                    fillColor: kPrimaryColor,
                    selectedColor: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  LineChartData mainData({List list}) {
    if (list == null) list = widget.currentList;
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: false,
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: list.length.toDouble(),
      minY: findMinValue(list: list),
      maxY: findMaxValue(list: list),
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (double i = 0; i < list.length; i++) FlSpot(i, list[i.toInt()].currentPrice),
          ],
          isCurved: true,
          colors: [kPrimaryColor],
          barWidth: 1.5,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false,
          ),
        ),
      ],
    );
  }
}
