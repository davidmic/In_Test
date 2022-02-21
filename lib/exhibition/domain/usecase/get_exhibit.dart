import 'package:in_test/exhibition/data/model/exhibit_model.dart';
import 'package:in_test/exhibition/domain/params/params.dart';
import 'package:in_test/exhibition/domain/repo/exhibit_repo.dart';
import 'package:in_test/src/api_result/api_result.dart';
import 'package:in_test/src/helper/usecase.dart';

class GetExhibits with UseCases<ApiResult<List<Exhibit>>, NoParams> {
  GetExhibits(this._repo);

  final ExhibitRepo _repo;

  @override
  Future<ApiResult<List<Exhibit>>> call(NoParams params) {
    return _repo.getExhibitList();
  }
}
