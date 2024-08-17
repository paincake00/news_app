import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/remove_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/save_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/bloc/local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance; // service locator

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton(database);

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // ApiService
  sl.registerSingleton<NewsApiService>(
    NewsApiService(sl()),
  );

  // Rep
  sl.registerSingleton<ArticleRepository>(
    ArticleRepositoryImpl(
      newsApiService: sl(),
      appDatabase: sl(),
    ),
  );

  // UseCases
  sl.registerSingleton<GetArticleUseCase>(
    GetArticleUseCase(articleRepository: sl()),
  );

  sl.registerSingleton<GetSavedArticlesUseCase>(
    GetSavedArticlesUseCase(articleRepository: sl()),
  );

  sl.registerSingleton<SaveArticleUseCase>(
    SaveArticleUseCase(articleRepository: sl()),
  );

  sl.registerSingleton<RemoveArticleUseCase>(
    RemoveArticleUseCase(articleRepository: sl()),
  );

  // Blocs
  sl.registerFactory<RemoteArticlesBloc>(
    () => RemoteArticlesBloc(getArticleUseCase: sl()),
  ); // register factory because bloc may be exposes multiple times

  sl.registerFactory<LocalArticleBloc>(
    () => LocalArticleBloc(
      getSavedArticlesUseCase: sl(),
      saveArticleUseCase: sl(),
      removeArticleUseCase: sl(),
    ),
  );
}
