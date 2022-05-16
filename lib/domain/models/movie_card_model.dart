class MovieCardModel {
  final int id;
  final String title;
  final String? picture;
  final double? voteAverage;
  final String? releaseDate;
  final String? description;
  final String? language;
  final int? runtime;
  const MovieCardModel({
    required this.id,
    required this.title,
    this.picture,
    this.voteAverage,
    this.releaseDate,
    this.description,
    this.language,
    this.runtime,
  });
}
