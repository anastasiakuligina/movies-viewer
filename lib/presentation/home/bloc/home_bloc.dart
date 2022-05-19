import 'package:films_viewer/data/repositories/movies_repository.dart';
import 'package:films_viewer/domain/models/movie_card_model.dart';
import 'package:films_viewer/presentation/home/bloc/home_event.dart';
import 'package:films_viewer/presentation/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:films_viewer/components/constants.dart';
import 'package:collection/collection.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MoviesRepository repository;
  HomeBloc(this.repository) : super(const HomeState()) {
    on<LoadDataEvent>(_onLoadData);
    on<SearchChangedEvent>(_onSearchChanged);
    on<PullToRefreshEvent>(_onPullToRefresh);
    on<ChangedFavourites>(_onChangedFavourites);
    on<ChangedMoviesDB>(_onChangedDB);

    repository
        .onChangedMoviesDB()
        .listen((List<MovieCardModel> changedMovieDB) {
      add(ChangedMoviesDB(models: changedMovieDB));
    });
  }
  String get search {
    final stateSearch = state.search;
    return ((stateSearch != null) && stateSearch.isNotEmpty)
        ? stateSearch
        : MovieQuery.initialQ;
  }

  void _onSearchChanged(SearchChangedEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(search: event.search));
    emit(state.copyWith(data: repository.loadData(q: search)));
  }

  void _onLoadData(LoadDataEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(data: repository.loadData(q: search)));
  }

  void _onPullToRefresh(PullToRefreshEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(data: repository.loadData(q: search)));
  }

  void _onChangedFavourites(
      ChangedFavourites event, Emitter<HomeState> emit) async {
    final MovieCardModel? targetMovie = event.model;
    MovieCardModel? movie;
    if (state.favouritesMovies?.isNotEmpty == true) {
      movie = state.favouritesMovies
          ?.firstWhereOrNull((element) => element?.id == targetMovie?.id);
    }
    if (movie != null) {
      await repository.deleteMovieDB(movie.id);
    } else if (targetMovie != null) {
      await repository.insertMovieDB(targetMovie);
    }
  }

  void _onChangedDB(ChangedMoviesDB event, Emitter<HomeState> emit) {
    emit(state.copyWith(favouritesMovies: event.models));
  }
}
