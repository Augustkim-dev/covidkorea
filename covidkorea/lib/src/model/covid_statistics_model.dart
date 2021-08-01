import 'package:xml/xml.dart';

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
