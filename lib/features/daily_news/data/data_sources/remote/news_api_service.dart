import 'package:dio/dio.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:retrofit/retrofit.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/everything')
  Future<HttpResponse<List<ArticleModel>>> getNewArticles({
    @Query('apiKey') String? apiKey,
    @Query('q') String? query,
    @Query('language') String? languageQuery,
    @Query('sortBy') String? sortByQuery,
  });
}
