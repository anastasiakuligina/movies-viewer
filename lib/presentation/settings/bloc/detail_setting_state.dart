import 'package:equatable/equatable.dart';
import 'package:films_viewer/domain/models/movie_card_model.dart';

class DetailSettingState extends Equatable {
  final MovieCardModel? model;
  const DetailSettingState({this.model});
  DetailSettingState copyWith({MovieCardModel? model}) =>
      DetailSettingState(model: model ?? this.model);
  @override
  List<Object> get props => [model ?? ''];
}
