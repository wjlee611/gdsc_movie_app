enum TMDBMovieListType {
  nowPlaying('now_playing'),
  popular('popular'),
  topRated('top_rated'),
  upComing('upcoming'),
  day('day'),
  week('week');

  final String endPoint;

  const TMDBMovieListType(this.endPoint);
}
