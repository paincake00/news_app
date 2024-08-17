import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

class GetArticleUseCase
    implements UseCase<DataState<List<ArticleEntity>>, String> {
  final ArticleRepository _articleRepository;

  GetArticleUseCase({
    required ArticleRepository articleRepository,
  }) : _articleRepository = articleRepository;

  @override
  Future<DataState<List<ArticleEntity>>> call({required String params}) {
    return _articleRepository.getNewArticles(params);
  }
}
