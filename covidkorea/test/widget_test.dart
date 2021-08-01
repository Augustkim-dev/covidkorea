// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:xml/xml.dart';

void main() {
  final bookshelfXml =
      '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<response>
    <header>
        <resultCode>00</resultCode>
        <resultMsg>NORMAL SERVICE.</resultMsg>
    </header>
    <body>
        <items>
            <item>
                <accDefRate>1.7441915681</accDefRate>
                <accExamCnt>11750344</accExamCnt>
                <accExamCompCnt>11371744</accExamCompCnt>
                <careCnt>22073</careCnt>
                <clearCnt>174177</clearCnt>
                <createDt>2021-08-01 09:38:06.089</createDt>
                <deathCnt>2095</deathCnt>
                <decideCnt>198345</decideCnt>
                <examCnt>378600</examCnt>
                <resutlNegCnt>11173399</resutlNegCnt>
                <seq>590</seq>
                <stateDt>20210801</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>null</updateDt>
            </item>
            <item>
                <accDefRate>1.7460531250</accDefRate>
                <accExamCnt>11728821</accExamCnt>
                <accExamCompCnt>11359620</accExamCompCnt>
                <careCnt>22073</careCnt>
                <clearCnt>174177</clearCnt>
                <createDt>2021-07-31 09:37:25.702</createDt>
                <deathCnt>2095</deathCnt>
                <decideCnt>198345</decideCnt>
                <examCnt>369201</examCnt>
                <resutlNegCnt>11161275</resutlNegCnt>
                <seq>589</seq>
                <stateDt>20210731</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>null</updateDt>
            </item>
        </items>
        <numOfRows>10</numOfRows>
        <pageNo>1</pageNo>
        <totalCount>2</totalCount>
    </body>
</response>''';

  test('코로나 통계', () {
    final document = XmlDocument.parse(bookshelfXml);
    final items = document.findAllElements('item');

    //titles.map((node) => node.text).forEach(print);

    var covid19Static = <Covid19StatisticsModel>[];


    items.forEach((node) {
      covid19Static.add(Covid19StatisticsModel.fromXml(node));
      //node.findAllElements('accDefRate').map((e) => e.text).forEach(print);
    });
    covid19Static.forEach((covid19) {
      print('${covid19.stateDt} : ${covid19.decideCnt}');
    });
    
  });
}

class Covid19StatisticsModel {
  String? accDefRate;
  String? accExamCnt;
  String? accExamCompCnt;
  String? careCnt;
  String? clearCnt;
  String? createDt;
  String? deathCnt;
  String? decideCnt;
  String? examCnt;
  String? resutlNegCnt;
  String? seq;
  String? stateDt;
  String? stateTime;
  String? updateDt;

  Covid19StatisticsModel({
    this.accDefRate,
    this.accExamCnt,
    this.accExamCompCnt,
    this.careCnt,
    this.clearCnt,
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.examCnt,
    this.resutlNegCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt,
  });

  factory Covid19StatisticsModel.fromXml(XmlElement xml) {
    return Covid19StatisticsModel(
      accDefRate: xml.findAllElements('accDefRate').map((e) => e.text).first,
      accExamCnt: xml.findAllElements('accExamCnt').map((e) => e.text).first,
      accExamCompCnt: xml.findAllElements('accExamCompCnt').map((e) => e.text).first,
      careCnt: xml.findAllElements('careCnt').map((e) => e.text).first,
      clearCnt: xml.findAllElements('clearCnt').map((e) => e.text).first,
      createDt: xml.findAllElements('createDt').map((e) => e.text).first,
      deathCnt: xml.findAllElements('deathCnt').map((e) => e.text).first,
      decideCnt: xml.findAllElements('decideCnt').map((e) => e.text).first,
      examCnt: xml.findAllElements('examCnt').map((e) => e.text).first,
      resutlNegCnt: xml.findAllElements('resutlNegCnt').map((e) => e.text).first,
      seq: xml.findAllElements('seq').map((e) => e.text).first,
      stateDt: xml.findAllElements('stateDt').map((e) => e.text).first,
      stateTime: xml.findAllElements('stateTime').map((e) => e.text).first,
      updateDt: xml.findAllElements('updateDt').map((e) => e.text).first,
    );
  }
}
