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

  Future<List<Covid19StatisticsModel>> fetchCovidStatistics(
      {String? startDate, String? endDate}) async {
    var query = Map<String, String>();
    if (startDate != null) query.putIfAbsent('startCreateDt', () => startDate);
    if (endDate != null) query.putIfAbsent('endCreateDt', () => endDate);

    var response = await _dio.get(
      '/openapi/service/rest/Covid19/getCovid19InfStateJson',
      queryParameters: query,
    );

    final document = XmlDocument.parse(response.data);
    final results = document.findAllElements('item');

    if (results.isNotEmpty) {
      return results
          .map<Covid19StatisticsModel>((e) => Covid19StatisticsModel.fromXml(e))
          .toList();

      // return Covid19StatisticsModel.fromXml(results.first);
    } else {
      return Future.value(null);
    }
  }
}
