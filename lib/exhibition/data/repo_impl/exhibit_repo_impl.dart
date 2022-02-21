import 'package:in_test/exhibition/data/datasource/exhibit.dart';
import 'package:in_test/exhibition/data/model/exhibit_model.dart';
import 'package:in_test/exhibition/domain/repo/exhibit_repo.dart';
import 'package:in_test/src/api_result/api_result.dart';
import 'package:in_test/src/services/dio_interceptor.dart';

class ExhibitRepoImpl implements ExhibitRepo {
  final ExhibitsLoader _exhibitsLoader;
  ExhibitRepoImpl(this._exhibitsLoader);

  @override
  Future<ApiResult<List<Exhibit>>> getExhibitList() async {
    return dioInterceptor(() => _exhibitsLoader.getExhibitList());
  }
}
