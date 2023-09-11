import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movies.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MovieDatasource {
  final dio =
      Dio(BaseOptions(baseUrl: 'http://api.themoviedb.org/3', queryParameters: {
    'api_key': Enviroment.theMovieDbKey,
    'lenguage': 'es-MX',
  }));
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final List<Movie> movies = [];
    return [];
  }
}
