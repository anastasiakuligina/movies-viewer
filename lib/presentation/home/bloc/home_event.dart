import 'package:equatable/equatable.dart';
import 'package:films_viewer/domain/models/movie_card_model.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SearchChangedEvent extends HomeEvent {
  final String search;
  const SearchChangedEvent({required this.search});

  @override
  List<Object> get props => [search];
}

class LoadDataEvent extends HomeEvent {}

class PullToRefreshEvent extends HomeEvent {}

class ChangedFavourites extends HomeEvent {
  final MovieCardModel? model;
  const ChangedFavourites({required this.model});
}

class ChangedMoviesDB extends HomeEvent {
  final List<MovieCardModel> models;
  const ChangedMoviesDB({required this.models});
}
