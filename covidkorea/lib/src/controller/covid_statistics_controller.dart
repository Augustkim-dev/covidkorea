import 'package:covidkorea/src/canvas/arrow_clip_path.dart';
import 'package:covidkorea/src/model/covid_statistics_model.dart';
import 'package:covidkorea/src/repository/covid_statistics_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CovidStatisticsController extends GetxController {
  late CovidStatisticsRepository _covidStatisticsRepository;

  Rx<Covid19StatisticsModel> _todayData = Covid19StatisticsModel().obs;
  RxList<Covid19StatisticsModel> _weekDatas = <Covid19StatisticsModel>[].obs;
  double maxDecideValue = 0;

  @override
  void onInit() {
    super.onInit();
    _covidStatisticsRepository = CovidStatisticsRepository();

    fetchCovidStatistics();
  }

  void fetchCovidStatistics() async {
    var startDate = DateFormat('yyyyMMdd')
        .format(DateTime.now().subtract(Duration(days: 8)));
    var endDate = DateFormat('yyyyMMdd').format(DateTime.now());

    var result = await _covidStatisticsRepository.fetchCovidStatistics(
        startDate: startDate, endDate: endDate);

    if (result.isNotEmpty) {
      for (var i = 0; i < result.length; i++) {
        if (i < result.length - 1) {
          result[i].updateCalcAboutYesterday(result[i + 1]);
          if(maxDecideValue < result[i].calcDecideCnt) {
            maxDecideValue = result[i].calcDecideCnt;
          }
        }
      }
      _weekDatas.addAll(result.sublist(0, result.length - 1).reversed);
      _todayData(_weekDatas.last);
    }
  }

  Covid19StatisticsModel get todayData => _todayData.value;
  List<Covid19StatisticsModel> get weekDays => _weekDatas;

  ArrowDirection calculrateUpDown(double value) {
    if(value == 0) {
      return ArrowDirection.MIDDLE;
    } else if (value > 0) {
      return ArrowDirection.UP;
    } else {
      return ArrowDirection.DOWN;
    }
  }
}
