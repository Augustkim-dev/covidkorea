import 'package:covidkorea/src/utils.dart/data_utils.dart';
import 'package:covidkorea/src/utils.dart/xml_utils.dart';
import 'package:xml/xml.dart';

class Covid19StatisticsModel {
  double? accDefRate;
  double? accExamCnt;
  double? accExamCompCnt;
  double? careCnt;
  double? clearCnt;
  double? deathCnt;
  double? decideCnt;
  double? examCnt;
  double? resutlNegCnt;
  double? seq;
  double calcClearCnt = 0;
  double calcDeathCnt = 0;
  double calcDecideCnt = 0;
  double calcExamCnt = 0;
  String? createDt;
  DateTime? stateDt;
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

  factory Covid19StatisticsModel.empty() {
    return Covid19StatisticsModel();
  }

  factory Covid19StatisticsModel.fromXml(XmlElement xml) {
    return Covid19StatisticsModel(
      accDefRate: XmlUtils.searchResultForDouble(xml, 'accDefRate'),
      accExamCnt: XmlUtils.searchResultForDouble(xml, 'accDefRate'),
      accExamCompCnt: XmlUtils.searchResultForDouble(xml, 'accExamCompCnt'),
      careCnt: XmlUtils.searchResultForDouble(xml, 'careCnt'),
      clearCnt: XmlUtils.searchResultForDouble(xml, 'clearCnt'),
      deathCnt: XmlUtils.searchResultForDouble(xml, 'deathCnt'),
      decideCnt: XmlUtils.searchResultForDouble(xml, 'decideCnt'),
      examCnt: XmlUtils.searchResultForDouble(xml, 'examCnt'),
      resutlNegCnt: XmlUtils.searchResultForDouble(xml, 'resutlNegCnt'),
      seq: XmlUtils.searchResultForDouble(xml, 'seq'),
      createDt: XmlUtils.searchResultForString(xml, 'createDt'),
      stateDt: XmlUtils.searchResultForString(xml, 'stateDt') != ''
          ? DateTime.parse(XmlUtils.searchResultForString(xml, 'stateDt'))
          : null,
      stateTime: XmlUtils.searchResultForString(xml, 'stateTime'),
      updateDt: XmlUtils.searchResultForString(xml, 'updateDt'),
    );
  }

  void updateCalcAboutYesterday(Covid19StatisticsModel yesterdayData) {
    _updateCalcDecideCnt(yesterdayData.decideCnt!);
    _updateCalcExamCnt(yesterdayData.examCnt!);
    _updateCalcDeathCnt(yesterdayData.deathCnt!);
    _updateCalcClearCnt(yesterdayData.clearCnt!);
  }

  _updateCalcDecideCnt(double beforeCnt) {
    calcDecideCnt = decideCnt! - beforeCnt;
  }

  _updateCalcExamCnt(double beforeCnt) {
    calcExamCnt = examCnt! - beforeCnt;
  }

  _updateCalcDeathCnt(double beforeCnt) {
    calcDeathCnt = deathCnt! - beforeCnt;
  }

  _updateCalcClearCnt(double beforeCnt) {
    calcClearCnt = clearCnt! - beforeCnt;
  }

  String get standardDayString => stateDt == null
      ? ''
      : '${DataUtils.simpleDayFormat(stateDt!)} $stateTime ??????';
}
