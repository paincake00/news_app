import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

class GetSavedArticlesUseCase implements UseCase<List<ArticleEntity>, void> {
  final ArticleRepository _articleRepository;

  GetSavedArticlesUseCase({
    required ArticleRepository articleRepository,
  }) : _articleRepository = articleRepository;

  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getSavedArticles();
  }
}
