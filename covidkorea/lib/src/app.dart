import 'package:covidkorea/src/controller/covid_statistics_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends GetView<CovidStatisticsController> {
  const App({Key? key}) : super(key: key);

  Widget infoWidget(String title, String value) {
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,),
                ),
                Text(" : $value", style: TextStyle(fontSize: 15,),
                ),
              ],),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("코로나 일별 현황"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Obx(() {
          var info = controller.covidStatisticsModel.value;
          return Column(children: [
              infoWidget("기준일", info.stateDt ?? ''),
              infoWidget("확진자수", info.decideCnt ?? '' ),
              

          ],);
        }),
      ),
    );
  }
}
