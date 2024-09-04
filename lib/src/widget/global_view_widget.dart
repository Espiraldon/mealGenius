import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mealgenius/src/data/data.dart';
import 'package:mealgenius/src/models/content.dart';

class GlobalViewWidget extends StatefulWidget {
  const GlobalViewWidget({super.key});

  @override
  State<GlobalViewWidget> createState() => _GlobalViewWidgetState();
}

class _GlobalViewWidgetState extends State<GlobalViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
            color: neutral, borderRadius: BorderRadius.circular(20)),
      ),
      Positioned(
          top: 10,
          left: 90,
          child: Text(
            'Global stock view',
            style: GoogleFonts.lato(
                color: tipo, fontSize: 25, fontWeight: FontWeight.w500),
          )),
      Positioned(
          bottom: 35,
          left: 30,
          child: Row(
            children: [
              Text(
                'Stock numbers : ',
                style: GoogleFonts.lato(
                    color: tipo, fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                '${myIngredients.fold(0.0, (previousValue, element) => previousValue + element.number)}',
                style: GoogleFonts.lato(
                    color: secondColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
      Positioned(
          bottom: 10,
          left: 30,
          child: Row(
            children: [
              Text(
                'Stock value : ',
                style: GoogleFonts.lato(
                    color: tipo, fontSize: 18, fontWeight: FontWeight.w500),
              ),
              Text(
                '${myIngredients.fold(0.0, (previousValue, element) => previousValue + element.cost * element.number)}€',
                style: GoogleFonts.lato(
                    color: secondColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
      Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: SizedBox(
            height: 120,
            width: double.infinity,
            child: BarChart(BarChartData(
              barGroups: [
                BarChartGroupData(x: 0, barRods: [
                  BarChartRodData(
                      color: primaryColor,
                      toY: double.parse(
                          '${myIngredients.where((element) => element.type == IngredientType.fruit).toList().fold(0, (previousValue, element) => previousValue + element.number.toInt())}'))
                ]),
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(
                      color: primaryColor,
                      toY: double.parse(
                          '${myIngredients.where((element) => element.type == IngredientType.vegetable).toList().fold(0, (previousValue, element) => previousValue + element.number.toInt())}'))
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(
                      color: primaryColor,
                      toY: double.parse(
                          '${myIngredients.where((element) => element.type == IngredientType.meat).toList().fold(0, (previousValue, element) => previousValue + element.number.toInt())}'))
                ]),
                BarChartGroupData(x: 3, barRods: [
                  BarChartRodData(
                      color: primaryColor,
                      toY: double.parse(
                          '${myIngredients.where((element) => element.type == IngredientType.feculent).toList().fold(0, (previousValue, element) => previousValue + element.number.toInt())}'))
                ]),
                BarChartGroupData(x: 4, barRods: [
                  BarChartRodData(
                      color: primaryColor,
                      toY: double.parse(
                          '${myIngredients.where((element) => element.type == IngredientType.salsa).toList().fold(0, (previousValue, element) => previousValue + element.number.toInt())}'))
                ]),
                BarChartGroupData(x: 5, barRods: [
                  BarChartRodData(
                      color: primaryColor,
                      toY: double.parse(
                          '${myIngredients.where((element) => element.type == IngredientType.dairyProducts).toList().fold(0, (previousValue, element) => previousValue + element.number.toInt())}'))
                ]),
                BarChartGroupData(x: 6, barRods: [
                  BarChartRodData(
                      color: primaryColor,
                      toY: double.parse(
                          '${myIngredients.where((element) => element.type == IngredientType.boisson).toList().fold(0, (previousValue, element) => previousValue + element.number.toInt())}'))
                ]),
                BarChartGroupData(x: 7, barRods: [
                  BarChartRodData(
                      color: primaryColor,
                      toY: double.parse(
                          '${myIngredients.where((element) => element.type == IngredientType.fish).toList().fold(0, (previousValue, element) => previousValue + element.number.toInt())}'))
                ]),
                BarChartGroupData(x: 8, barRods: [
                  BarChartRodData(
                      color: primaryColor,
                      toY: double.parse(
                          '${myIngredients.where((element) => element.type == IngredientType.carbohydrate).toList().fold(0, (previousValue, element) => previousValue + element.number.toInt())}'))
                ]),
                BarChartGroupData(x: 9, barRods: [
                  BarChartRodData(
                      color: primaryColor,
                      toY: double.parse(
                          '${myIngredients.where((element) => element.type == IngredientType.legume).toList().fold(0, (previousValue, element) => previousValue + element.number.toInt())}'))
                ]),
                BarChartGroupData(x: 10, barRods: [
                  BarChartRodData(
                      color: primaryColor,
                      toY: double.parse(
                          '${myIngredients.where((element) => element.type == IngredientType.pasta).toList().fold(0, (previousValue, element) => previousValue + element.number.toInt())}'))
                ]),
                BarChartGroupData(x: 11, barRods: [
                  BarChartRodData(
                      color: primaryColor,
                      toY: double.parse(
                          '${myIngredients.where((element) => element.type == IngredientType.other).toList().fold(0, (previousValue, element) => previousValue + element.number.toInt())}'))
                ]),
              ],
              titlesData: FlTitlesData(
                show: true,
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: const AxisTitles(
                    sideTitles: SideTitles(reservedSize: 35, showTitles: true)),
                bottomTitles: AxisTitles(
                  axisNameWidget: Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('F', style: GoogleFonts.lato(color: tipo)),
                        Text('V', style: GoogleFonts.lato(color: tipo)),
                        Text('M', style: GoogleFonts.lato(color: tipo)),
                        Text('FC', style: GoogleFonts.lato(color: tipo)),
                        Text('S', style: GoogleFonts.lato(color: tipo)),
                        Text('DP', style: GoogleFonts.lato(color: tipo)),
                        Text('M', style: GoogleFonts.lato(color: tipo)),
                        Text('FS', style: GoogleFonts.lato(color: tipo)),
                        Text('C', style: GoogleFonts.lato(color: tipo)),
                        Text('P', style: GoogleFonts.lato(color: tipo)),
                        Text('B', style: GoogleFonts.lato(color: tipo)),
                        Text('Other', style: GoogleFonts.lato(color: tipo)),
                      ],
                    ),
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
            ))),
      )
    ]);
  }
}
