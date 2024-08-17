import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

class RemoveArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  RemoveArticleUseCase({
    required ArticleRepository articleRepository,
  }) : _articleRepository = articleRepository;

  @override
  Future<void> call({required ArticleEntity params}) {
    return _articleRepository.removeArticle(params);
  }
}
