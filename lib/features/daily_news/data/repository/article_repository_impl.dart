import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl({
    required NewsApiService newsApiService,
    required AppDatabase appDatabase,
  })  : _newsApiService = newsApiService,
        _appDatabase = appDatabase;

  @override
  Future<DataState<List<ArticleModel>>> getNewArticles(String newQuery) async {
    try {
      final httpResponse = await _newsApiService.getNewArticles(
        apiKey: apiKey,
        query: newQuery.trim().isEmpty ? query : newQuery,
        languageQuery: languageQuery,
        sortByQuery: sortByQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.unknown,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      print(e.message!.toUpperCase());
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return _appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) async {
    return _appDatabase.articleDao
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) async {
    return _appDatabase.articleDao
        .insertArticle(ArticleModel.fromEntity(article));
  }
}
