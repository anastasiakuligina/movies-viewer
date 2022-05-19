import 'package:films_viewer/domain/models/movie_card_model.dart';
import 'package:films_viewer/presentation/settings/bloc/detail_setting_event.dart';
import 'package:films_viewer/presentation/settings/bloc/detail_setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailSettingBloc extends Bloc<DetailSettingEvent, DetailSettingState> {
  final String tagId = 'id';
  final String tagTitle = 'title';
  final String tagPicture = 'picture';
  final String tagReleaseDate = 'releaseDate';
  final String tagDescription = 'description';
  final String tagVoteAverage = 'voteAverage';
  DetailSettingBloc() : super(const DetailSettingState()) {
    on<SaveDetailPageEvent>(_onSaveDetailPage);
    on<LoadDetailPageEvent>(_onLoadDetailPage);
    on<ClearDetailPageEvent>(_onClearDetailPage);
  }
  void _onSaveDetailPage(
      SaveDetailPageEvent event, Emitter<DetailSettingState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(tagId, event.model.id);
    prefs.setString(tagTitle, event.model.title);
    prefs.setString(tagPicture, event.model.picture ?? '');
    prefs.setString(tagReleaseDate, event.model.releaseDate ?? '');
    prefs.setString(tagDescription, event.model.description ?? '');
    prefs.setDouble(tagVoteAverage, event.model.voteAverage ?? 0);
    emit(state.copyWith(model: event.model));
  }

  void _onLoadDetailPage(
      LoadDetailPageEvent event, Emitter<DetailSettingState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    MovieCardModel currentModel = MovieCardModel(
      id: prefs.getInt(tagId) ?? 0,
      title: prefs.getString(tagTitle) ?? '',
      picture: prefs.getString(tagPicture) ?? '',
      releaseDate: prefs.getString(tagReleaseDate) ?? '',
      description: prefs.getString(tagDescription),
      voteAverage: prefs.getDouble(tagVoteAverage),
    );
    emit(state.copyWith(model: currentModel));
  }

  void _onClearDetailPage(
      ClearDetailPageEvent event, Emitter<DetailSettingState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(tagId);
    prefs.remove(tagTitle);
    prefs.remove(tagPicture);
    prefs.remove(tagReleaseDate);
    prefs.remove(tagDescription);
    prefs.remove(tagVoteAverage);
    emit(state.copyWith(model: null));
  }
}
