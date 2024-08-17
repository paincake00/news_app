part of 'local_article_bloc.dart';

sealed class LocalArticlesState extends Equatable {
  final List<ArticleEntity>? articles;

  const LocalArticlesState({
    this.articles,
  });

  @override
  List<Object> get props => [
        articles!,
      ];
}

final class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading();
}

class LocalArticlesDone extends LocalArticlesState {
  const LocalArticlesDone({
    required List<ArticleEntity> articles,
  }) : super(articles: articles);
}
