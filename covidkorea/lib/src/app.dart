import 'package:covidkorea/src/canvas/arrow_clip_path.dart';
import 'package:covidkorea/src/controller/covid_statistics_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/bar_chart.dart';
import 'components/covid_statistics_viewer.dart';

class App extends GetView<CovidStatisticsController> {
  App({Key? key}) : super(key: key);
  late double hearderTopZone;

  Widget infoWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Text(
            " : $value",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _background() {
    return [
      Container(
        // padding: const EdgeInsets.all(15),
        // child: Obx(() {
        //   var info = controller.covidStatisticsModel.value;
        //   return Column(children: [
        //       infoWidget("기준일", info.stateDt ?? ''),
        //       infoWidget("확진자수", info.decideCnt ?? '' ),
        //   ],);
        // }),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Color(0xff3c727c),
              Colors.red,
            ],
          ),
        ),
      ),
      Positioned(
        left: -110,
        top: hearderTopZone + 40,
        child: Container(
          child: Image.asset(
            'assets/covid_img.png',
            width: Get.size.width * 0.7,
          ),
        ),
      ),
      Positioned(
        top: hearderTopZone + 10,
        left: 0,
        right: 0,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff195f68),
            ),
            child: Obx(
              () => Text(
                controller.todayData.standardDayString,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: hearderTopZone + 60,
        right: 40,
        child: Obx(
          () => CovidStatisticsViewer(
            addedCount: controller.todayData.calcDecideCnt,
            title: '확진자',
            totalCount: controller.todayData.decideCnt ?? 0,
            upDown:
                controller.calculrateUpDown(controller.todayData.calcDecideCnt),
            titleColor: Colors.white,
            subValueColor: Colors.white,
          ),
        ),
      ),
    ];
  }

  Widget _todayStatistics() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: CovidStatisticsViewer(
              addedCount: controller.todayData.calcClearCnt,
              title: '격리해제',
              totalCount: controller.todayData.clearCnt ?? 0,
              upDown: controller
                  .calculrateUpDown(controller.todayData.calcClearCnt),
              dense: true,
            ),
          ),
          Container(
            height: 60,
            child: VerticalDivider(
              color: Color(0xffc7c7c7),
            ),
          ),
          Expanded(
            child: CovidStatisticsViewer(
              addedCount: controller.todayData.calcExamCnt,
              title: '검사중',
              totalCount: controller.todayData.examCnt ?? 0,
              upDown:
                  controller.calculrateUpDown(controller.todayData.calcExamCnt),
              dense: true,
            ),
          ),
          Container(
            height: 60,
            child: VerticalDivider(
              color: Color(0xffc7c7c7),
            ),
          ),
          Expanded(
            child: CovidStatisticsViewer(
              addedCount: controller.todayData.calcDeathCnt,
              title: '사망자',
              totalCount: controller.todayData.deathCnt ?? 0,
              upDown:
                  controller.calculrateUpDown(controller.todayData.calcExamCnt),
              dense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _covidTrendsChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "확진자 추이",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        AspectRatio(
          aspectRatio: 1.7,
          child: Obx(
            () => controller.weekDays.length == 0
                ? Container()
                : CovidBarChart(
                    covidDatas: controller.weekDays,
                    maxY: controller.maxDecideValue,
                  ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    hearderTopZone = Get.mediaQuery.padding.top + AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: Text(
          "코로나 일별 현황",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          ..._background(),
          Positioned(
            top: hearderTopZone + 200,
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      // 정보영역 그리기
                      _todayStatistics(),
                      SizedBox(height: 20),
                      // 차트영역 그리기
                      _covidTrendsChart(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
