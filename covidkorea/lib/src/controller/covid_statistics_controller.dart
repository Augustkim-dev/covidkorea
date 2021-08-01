import 'package:covidkorea/src/model/covid_statistics_model.dart';
import 'package:covidkorea/src/repository/covid_statistics_repository.dart';
import 'package:get/get.dart';

class CovidStatisticsController extends GetxController {

  late CovidStatisticsRepository _covidStatisticsRepository;

  Rx<Covid19StatisticsModel> covidStatisticsModel = Covid19StatisticsModel().obs;

  @override
  void onInit() {
    super.onInit();
    _covidStatisticsRepository = CovidStatisticsRepository();
    
    fetchCovidStatistics();
   
  }

  void fetchCovidStatistics() async {
   var result = await _covidStatisticsRepository.fetchCovidStatistics();
   if(result != null) {
    covidStatisticsModel(result);
   }

  }
}