import 'package:covidkorea/src/model/covid_statistics_model.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class CovidStatisticsRepository {
  late var _dio;

  CovidStatisticsRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://openapi.data.go.kr",
        queryParameters: {
          'serviceKey':
              'yuKs8EJPgzBJXcpN/jS8Q3dm1hRta9/kvBkr8a8uwi0xxyb4RdBmHsO1CLTHJqZfreedEo4nYkPqeXpu3wGMOg=='
        },
      ),
    );
  }

  Future<Covid19StatisticsModel> fetchCovidStatistics() async {
    var response = await _dio.get('/openapi/service/rest/Covid19/getCovid19InfStateJson');

    final document = XmlDocument.parse(response.data);
    final results = document.findAllElements('item');

    if(results.isNotEmpty) {
      return Covid19StatisticsModel.fromXml(results.first);
    } else {
      return Future.value(null);
    }
  }

}
