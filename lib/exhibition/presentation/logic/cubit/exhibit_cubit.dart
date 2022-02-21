import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:in_test/exhibition/data/model/exhibit_model.dart';
import 'package:in_test/exhibition/domain/params/params.dart';
import 'package:in_test/exhibition/domain/usecase/get_exhibit.dart';

part 'exhibit_state.dart';

class ExhibitCubit extends Cubit<ExhibitState> {
  final GetExhibits _getExhibits;
  ExhibitCubit(this._getExhibits) : super(Initial());

  void getExhibits() async {
    emit(Loading());
    final result = await _getExhibits.call(NoParams());

    result.maybeWhen(
      success: (data) {
        emit(Loaded(data));
      },
      apiFailure: (e) {
        emit(Error(e));
      },
      orElse: () => emit(Error('Something went wrong')),
    );
  }
}
