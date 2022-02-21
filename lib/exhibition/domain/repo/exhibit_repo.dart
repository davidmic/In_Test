import 'package:in_test/exhibition/data/model/exhibit_model.dart';
import 'package:in_test/src/api_result/api_result.dart';

abstract class ExhibitRepo {
  Future<ApiResult<List<Exhibit>>> getExhibitList();
}
