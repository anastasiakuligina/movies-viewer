import 'package:equatable/equatable.dart';
import 'package:films_viewer/domain/models/movie_card_model.dart';

abstract class DetailSettingEvent extends Equatable {
  const DetailSettingEvent();

  @override
  List<Object> get props => [];
}

class SaveDetailPageEvent extends DetailSettingEvent {
  final MovieCardModel model;
  const SaveDetailPageEvent({required this.model});
  @override
  List<Object> get props => [model];
}

class LoadDetailPageEvent extends DetailSettingEvent {}

class ClearDetailPageEvent extends DetailSettingEvent {}
