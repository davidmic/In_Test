import 'package:in_test/exhibition/data/datasource/exhibit.dart';
import 'package:in_test/exhibition/data/model/exhibit_model.dart';
import 'package:in_test/src/services/dio_service.dart';

class RestExhibitsLoader implements ExhibitsLoader {
  final ApiClient _apiClient;
  RestExhibitsLoader(this._apiClient);

  @override
  Future<List<Exhibit>> getExhibitList() async {
    String url = "https://my-json-server.typicode.com/Reyst/exhibit_db/list";
    final res = await _apiClient.dio.get(url);
    List<dynamic> data = res.data;
    List<Exhibit> exhibit = data.map((e) => Exhibit.fromMap(e)).toList();
    return exhibit;
  }
}
