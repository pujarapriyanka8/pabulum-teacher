part of 'classwork_bloc.dart';

@freezed
abstract class ClassworkEvent with _$ClassworkEvent {
  const factory ClassworkEvent.onLoadClasswork({
    @Default(1) int page,
    @Default('') String query,
  }) = OnLoadClasswork;

  const factory ClassworkEvent.onLoadClassworkDetail({
    required String classworkId,
  }) = OnLoadClassworkDetail;

  const factory ClassworkEvent.onDeleteClasswork({
    required int classworkId,
  }) = OnDeleteClasswork;
}
