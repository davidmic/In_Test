import 'package:in_test/exhibition/data/model/exhibit_model.dart';

abstract class ExhibitsLoader {
  Future<List<Exhibit>> getExhibitList();
}
